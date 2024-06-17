import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/accessrequest_model.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/data/models/user_model.dart';
import 'package:meds_record/app/modules/home/controllers/fileupload_controller.dart';
import 'dart:core';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  CollectionReference getMedicalRecordsCollection() {
    return _db.collection('medical_records');
  }

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    return UserModel.fromDocumentSnapshot(doc);
  }

  Future<String?> getNIKByUID(String uid) async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        String nik = doc.get('nik');
        return nik;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot> getUserByPassword(String password) async {
    return await _db
        .collection('users')
        .where('password', isEqualTo: password)
        .get();
  }

  Future<void> addMedicalRecord(MedicalrecordModel record) async {
    final docRef = _db.collection('medical_records').doc();
    record.recordId = docRef.id;
    await docRef.set(record.toMap());
  }

  Future<void> addEncryptedMedicalRecord(
      MedicalrecordModel record, PlatformFile file) async {
    final fileUploadController = Get.find<FileUploadController>();
    final encryptedData = await fileUploadController.encryptAndUploadFile(file);
    final downloadUrl = encryptedData['downloadUrl'];
    final publicKey = encryptedData['publicKey'];
    final aesKey = encryptedData['aesKeyBytes'];
    final macBytes = encryptedData['macBytes'];
    final aesNonce = encryptedData['aesNonce'];
    final cipherText = encryptedData['cipherText'];

    record.pdfUrl = downloadUrl;
    record.publicKey = publicKey;
    record.aesKey = aesKey;
    record.macBytes = macBytes;
    record.aesNonce = aesNonce;
    record.cipherText = cipherText;
    await addMedicalRecord(record);
  }

  Future<List<MedicalrecordModel>> getMedicalRecordsStream(
      String patientId) async {
    QuerySnapshot snapshot = await _db
        .collection('medical_records')
        .where('patientId', isEqualTo: patientId)
        .get();
    return snapshot.docs
        .map((doc) => MedicalrecordModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<String?> getPatientIdByNik(String nik) async {
    QuerySnapshot query = await _db
        .collection('users')
        .where('nik', isEqualTo: nik)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    } else {
      return null;
    }
  }

  Future<Map<String, String>> getSecretKeyByNik(String nik) async {
    QuerySnapshot query = await _db
        .collection('medical_records')
        .where('nik', isEqualTo: nik)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return {
        'aesKeyBytes': doc['aesKeyBytes'] as String,
        'publicKey': doc['publicKey'] as String,
        'macBytes': doc['macBytes'] as String,
        'cipherText': doc['cipherText'] as String,
        'aesNonce': doc['aesNonce'] as String
      };
    } else {
      return {
        'aesKeyBytes': '',
        'publicKey': '',
        'macBytes': '',
        'cipherText': '',
        'aesNonce': ''
      };
    }
  }

  Future<List<UserModel>> searchUsers(String query, String role) async {
    if (query.isEmpty) {
      return [];
    }

    QuerySnapshot snapshot = await _db
        .collection('users')
        .where('nik', isGreaterThanOrEqualTo: query)
        .where('nik', isLessThanOrEqualTo: query + '\uf8ff')
        .where('role', isEqualTo: role) // Check if the role is also 'patient'
        .get();
    return snapshot.docs
        .map((doc) => UserModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<void> addAccesRequest(AccessRequestModel request) async {
    final docRef = _db.collection('access_requests').doc();
    request.requestId = docRef.id;
    await docRef.set(request.toMap());
  }

  Future<List<AccessRequestModel>> getRequestForUser(String idOwner) async {
    QuerySnapshot snapshot = await _db
        .collection('access_requests')
        .where('idOwner', isEqualTo: idOwner)
        .where('status', isEqualTo: 'pending')
        .get();

    return snapshot.docs
        .map((doc) => AccessRequestModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<void> updateRequestStatus(String requestId, String status) async {
    await _db
        .collection('access_requests')
        .doc(requestId)
        .update({'status': status});
  }

  Future<DocumentSnapshot> getMedicalRecordById(String id) async {
    return await _db.collection('medical_records').doc(id).get();
  }

  Future<List<MedicalrecordModel>> getMedicalRecordByRecordId(
      String recordId) async {
    QuerySnapshot snapshot = await _db
        .collection('medical_records')
        .where('recordId', isEqualTo: recordId)
        .get();
    return snapshot.docs
        .map((doc) => MedicalrecordModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<List<AccessRequestModel>> getApprovedMedicalRecordByNIK(
      String nik) async {
    QuerySnapshot snapshot = await _db
        .collection('access_requests')
        .where('nik', isEqualTo: nik)
        .where('status', isEqualTo: 'approved')
        .get();
    return snapshot.docs
        .map((doc) => AccessRequestModel.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<bool> validateOldPassword(String uid, String oldPassword) async {
    try {
      QuerySnapshot result = await _db
          .collection('users')
          .where('uid', isEqualTo: uid)
          .where('password', isEqualTo: oldPassword)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error validaing old password: $e');
    }
  }

  Future<void> updateUserPassword(String uid, String newPassword) async {
    try {
      await _db.collection('users').doc(uid).update({'password': newPassword});
    } catch (e) {
      throw Exception('Error updating user password: $e');
    }
  }
}
