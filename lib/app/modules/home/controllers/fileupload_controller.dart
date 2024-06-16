import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meds_record/app/services/firestore_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show Uint8List;
import 'package:cryptography/cryptography.dart';

class FileUploadController extends GetxController {
  Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final Cipher aesCipher = AesGcm.with256bits();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      await convertToPdf(file);
    }
  }

  void removeFile() {
    selectedFile.value = null;
  }

  Future<void> convertToPdf(PlatformFile file) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(File(file.path!).readAsBytesSync());

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      );
    }));

    final output = await getTemporaryDirectory();
    final pdfFile = File("${output.path}/${file.name.split('.').first}.pdf");
    await pdfFile.writeAsBytes(await pdf.save());

    selectedFile.value = PlatformFile(
      name: pdfFile.path.split('/').last,
      path: pdfFile.path,
      size: await pdfFile.length(),
    );
  }

  Future<Map<String, String>> encryptAndUploadFile(PlatformFile file) async {
    // Read the file
    final fileData = await File(file.path!).readAsBytes();

    late final SimpleKeyPair edKeyPair;
    edKeyPair = await Ed25519().newKeyPair();
    final publicKeyBytes = await edKeyPair.extractPublicKey();

    final aesKey = await aesCipher.newSecretKey();
    final aesKeyBytes = await aesKey.extractBytes();

    final aesNonce = aesCipher.newNonce();
    final aesEncrypted =
        await aesCipher.encrypt(fileData, secretKey: aesKey, nonce: aesNonce);

    final edSignature = await Ed25519().sign(aesKeyBytes, keyPair: edKeyPair);

    final combinedBytes = Uint8List.fromList([
      ...aesEncrypted.cipherText,
      ...aesNonce,
      ...aesEncrypted.mac.bytes,
      ...edSignature.bytes
    ]);
    // Upload encrypted file to Firebase Storage
    final storageRef = _storage.ref().child("uploads/${file.name}");
    final uploadTask = storageRef.putData(combinedBytes);

    final snapshot = await uploadTask;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    // Save secretKey to Firestore
    return {
      'downloadUrl': downloadUrl,
      'publicKey': base64Encode(publicKeyBytes.bytes),
      'aesKeyBytes': base64Encode(aesKeyBytes),
      'macBytes': base64Encode(aesEncrypted.mac.bytes),
      'aesNonce': base64Encode(aesNonce),
      'cipherText': base64Encode(aesEncrypted.cipherText)
    };
  }

  Future<void> downloadAndDecryptFile(String downloadUrl, String nik) async {
    // Extract file name from the download URL
    final fileName = Uri.parse(downloadUrl).pathSegments.last;

    // Download encrypted file from Firebase Storage
    final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
    final downloadData = await ref.getData();

    final keys = await FirestoreService().getSecretKeyByNik(nik);
    final publicKeyBase64 = keys['publicKey'];
    final publicAesKeyBase64 = keys['aesKeyBytes'];
    final macBytes = keys['macBytes'];
    final aesNonce = keys['aesNonce'];
    final cipherText = keys['cipherText'];

    final encryptedFileLength = downloadData!.length - 12 - 16 - 64;
    final edSignatureBytes = downloadData.sublist(encryptedFileLength + 28);

    final publicKeyDecode64 = base64Decode(publicKeyBase64!);
    final publicAesKeyDecode64 = base64Decode(publicAesKeyBase64!);
    final macBytesDecode64 = base64Decode(macBytes!);
    final aesNonceDecode64 = base64Decode(aesNonce!);
    final cipherTextDecode64 = base64Decode(cipherText!);

    final publicKey =
        SimplePublicKey(publicKeyDecode64, type: KeyPairType.ed25519);

    final edSignature = Signature(edSignatureBytes, publicKey: publicKey);
    final isValid =
        await Ed25519().verify(publicAesKeyDecode64, signature: edSignature);

    if (!isValid) {
      throw Exception("Signature verification failed");
    }

    final aesKey = SecretKey(publicAesKeyDecode64);

    final aesDecrypted = await aesCipher.decrypt(
        SecretBox(cipherTextDecode64,
            nonce: aesNonceDecode64, mac: Mac(macBytesDecode64)),
        secretKey: aesKey);

    // Save the decrypted file to temporary directory with the original file name
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.pdf';
    final pdfFile = File(filePath);

    if (!pdfFile.existsSync()) {
      await pdfFile.create(recursive: true);
    }

    await pdfFile.writeAsBytes(aesDecrypted, mode: FileMode.write);

    Get.toNamed('/viewpdf',
        arguments: {'filePath': pdfFile.path, 'fileName': fileName});
  }
}
