import 'package:get/get.dart';
import 'package:meds_record/app/data/models/accessrequest_model.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/services/firestore_service.dart';

class AccessRequestController extends GetxController {
  var isLoading = false.obs;
  var request = <AccessRequestModel>[].obs;
  var approvedMedicalRecords = <MedicalrecordModel>[].obs;

  final FirestoreService firestoreService = FirestoreService();

  Future<void> requestAccess(String nik, String instansi, String keperluan,
      String nama, String medicalRecordId, String idOwner) async {
    try {
      isLoading(true);
      AccessRequestModel accessRequest = AccessRequestModel(
          requestId: '',
          idOwner: idOwner,
          nik: nik,
          name: nama,
          instansiName: instansi,
          medicalRecordId: medicalRecordId,
          keperluan: keperluan,
          status: 'pending');
      await firestoreService.addAccesRequest(accessRequest);
      Get.snackbar('Success', 'Permintaan Berhasil Dikirim');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRequestForUser(String userId) async {
    try {
      isLoading(true);
      List<AccessRequestModel> fetchRequest =
          await firestoreService.getRequestForUser(userId);
      request.assignAll(fetchRequest);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
