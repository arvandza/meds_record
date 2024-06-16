import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/services/firestore_service.dart';
import 'dart:core';

class MedicalRecordController extends GetxController {
  var medicalRecord = <MedicalrecordModel>[].obs;
  var isLoading = false.obs;
  final FirestoreService firestoreService = FirestoreService();

  Future<void> listenToMedicalRecord(String patientId) async {
    isLoading(true);
    final result = await firestoreService.getMedicalRecordsStream(patientId);
    medicalRecord.assignAll(result);
    isLoading(false);
  }

  Future<void> saveRecord(MedicalrecordModel record, PlatformFile file) async {
    try {
      isLoading(true);
      final patientId = await firestoreService.getPatientIdByNik(record.nik!);
      if (patientId != null) {
        record.patientId = patientId;
        await firestoreService.addEncryptedMedicalRecord(record, file);
        Get.snackbar('Success', 'Data berhasil ditambahkan',
            icon: const Icon(Icons.check, color: Colors.white),
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
        isLoading(false);
      } else {
        Get.snackbar('Error', 'NIK not found');
        isLoading(false);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
