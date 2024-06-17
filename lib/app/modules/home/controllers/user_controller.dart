import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/accessrequest_model.dart';

import '../../../data/models/medicalrecord_model.dart';
import '../../../data/models/user_model.dart';
import '../../../services/firestore_service.dart';

class UserController extends GetxController {
  var medicalRecord = <MedicalrecordModel>[].obs;
  var reqRecord = <MedicalrecordModel>[].obs;
  var requestRecord = <AccessRequestModel>[].obs;
  var approvedRecord = <MedicalrecordModel>[].obs;
  var isLoading = false.obs;
  final FirestoreService firestoreService = FirestoreService();

  @override
  void onInit() async {
    super.onInit();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    getPatientId(userId);
    listenToRequest(userId);
    fetchApprovedMedicalRecords(userId);
  }

  void getPatientId(String userId) async {
    UserModel user = await firestoreService.getUser(userId);
    listenToMedicalRecord(user.uid!);
  }

  Future<void> listenToMedicalRecord(String patientId) async {
    isLoading(true);
    final result = await firestoreService.getMedicalRecordsStream(patientId);
    medicalRecord.assignAll(result);
    isLoading(false);
  }

  Future<void> listenToRequest(String idOwner) async {
    isLoading(true);
    final result = await firestoreService.getRequestForUser(idOwner);
    requestRecord.assignAll(result);
    isLoading(false);
  }

  Future<void> listenToRequestMedicalRecord(String recordId) async {
    isLoading(true);
    final result = await firestoreService.getMedicalRecordByRecordId(recordId);
    reqRecord.assignAll(result);
    isLoading(false);
  }

  Future<void> acceptRequest(String recordId) async {
    isLoading(true);
    await firestoreService.updateRequestStatus(recordId, 'approved');
    isLoading(false);
  }

  Future<void> deniedRequest(String recordId) async {
    isLoading(true);
    await firestoreService.updateRequestStatus(recordId, 'denied');
    isLoading(false);
  }

  Future<void> fetchApprovedMedicalRecords(String uid) async {
    try {
      isLoading(true);
      String? nikValue = await firestoreService.getNIKByUID(uid);
      // Ambil semua medicalRecordId yang terapproved dari access_requests
      QuerySnapshot accessRequestSnapshot = await FirebaseFirestore.instance
          .collection('access_requests')
          .where('nik', isEqualTo: nikValue)
          .where('status', isEqualTo: 'approved')
          .get();

      List<String> approvedRecordIds = accessRequestSnapshot.docs
          .map((doc) => doc['medicalRecordId'] as String)
          .toList();

      // Ambil data medical_records berdasarkan medicalRecordId yang telah didapatkan
      List<MedicalrecordModel> records = [];
      for (String recordId in approvedRecordIds) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('medical_records')
            .doc(recordId)
            .get();

        if (doc.exists) {
          records.add(MedicalrecordModel.fromDocumentSnapshot(doc));
        }
      }
      approvedRecord.value = records;
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
