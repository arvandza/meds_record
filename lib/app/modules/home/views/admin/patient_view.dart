// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/modules/home/controllers/medicalrecord_controller.dart';
import 'package:meds_record/app/modules/home/controllers/search_controller.dart';
import 'package:meds_record/app/services/firestore_service.dart';

import '../../../../data/listrecord.dart';

class PatientView extends StatelessWidget {
  PatientView({super.key});

  final SearchingController searchingController =
      Get.put(SearchingController());

  final MedicalRecordController medicalrecordController =
      Get.put(MedicalRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) => searchingController.query.value = value,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
              hintText: 'Cari pasien berdasarkan NIK',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xFF097EDA)),
              ),
              fillColor: Colors.grey.shade100,
              filled: true,
            ),
          ),
          const SizedBox(height: 28),
          Expanded(child: Obx(
            () {
              if (searchingController.users.isEmpty) {
                return const Center(child: Text('No data found'));
              }
              if (searchingController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: searchingController.users.length,
                  itemBuilder: (context, index) {
                    final record = searchingController.users[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.green, // Warna border bawah
                            width: 1, // Ketebalan border bawah
                          ),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2.0,
                            offset: Offset(0, 1),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        title: Text(record.email!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NIK: ${record.nik}'),
                          ],
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade500,
                          size: 16,
                        ),
                        onTap: () async {
                          if (record.uid != null) {
                            // Check if the UID is not null
                            await medicalrecordController
                                .listenToMedicalRecord(record.uid!);
                            Get.toNamed('/patientdetails');
                          } else {
                            // Handle the case where UID is null
                            print('UID is null');
                          }
                        },
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }
}
