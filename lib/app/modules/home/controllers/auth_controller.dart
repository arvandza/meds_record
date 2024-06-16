import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/services/firestore_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/models/user_model.dart';
import '../views/widget/custom_dialog.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  RxString userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.userChanges());
    _requestPermission(Permission.storage);
  }

  void registerPatient(String email, String nik) async {
    try {
      isLoading.value = true;
      String password = _generateRandomPassword();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel newUser = UserModel(
          uid: userCredential.user!.uid,
          email: email,
          nik: nik,
          password: password,
          role: 'patient');
      await FirestoreService().addUser(newUser);
      isLoading.value = false;
      Get.dialog(CustomDialog(
          title: 'Success',
          buttonText: 'Export',
          description: 'Your Generated Key:',
          onPressed: () async {
            await exportPasswordToFile(password);
          },
          randomVar: password));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login(String password) async {
    try {
      isLoading.value = true;
      QuerySnapshot result =
          await FirestoreService().getUserByPassword(password);
      if (result.docs.isEmpty) {
        Get.snackbar('Error', 'No user found with this password');
        return false;
      }
      var user = result.docs.first.data() as Map<String, dynamic>;
      await auth.signInWithEmailAndPassword(
          email: user['email'], password: password);

      userRole.value = user['role'];
      isLoading.value = false;
      return true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await auth.signOut();
      userRole.value = '';
      isLoading.value = false;
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePassword(String uid, String oldPassword) async {
    try {
      isLoading(true);
      bool isValid =
          await FirestoreService().validateOldPassword(uid, oldPassword);
      if (isValid) {
        String newPassword = _generateRandomPassword();
        User? user = auth.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
          await FirestoreService().updateUserPassword(uid, newPassword);
          isLoading(false);
          Get.dialog(CustomDialog(
            title: 'Success',
            buttonText: 'Export',
            description: 'Your New Generated Key:',
            randomVar: newPassword,
            onPressed: () async {
              await exportPasswordToFile(newPassword);
            },
          ));
        } else {
          Get.snackbar('Failed', 'Gagal mengganti password');
        }
      } else {
        throw Exception('No user is signed in');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  String _generateRandomPassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      6,
      (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }

  Future<void> exportPasswordToFile(String password) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory != null) {
        final path = '$selectedDirectory/password.txt';
        final file = File(path);
        await file.writeAsString('Generated Password: $password');
        Get.snackbar('Success', 'Password saved to file: $path');
      } else {
        Get.snackbar('Error', 'No directory selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save password to file: $e');
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      if (re.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}
