// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_card.dart';

import '../../../../data/models/medicalrecord_model.dart';
import '../../controllers/fileupload_controller.dart';

class PatientDetails2 extends StatelessWidget {
  PatientDetails2({super.key});

  final MedicalrecordModel record = Get.arguments;

  final FileUploadController fileUploadController =
      Get.put(FileUploadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Record Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomCard.buildPersonalDetails(record),
            const SizedBox(height: 16.0),
            CustomCard.buildMedicalHistory(record),
            const SizedBox(height: 32.0),
            FilledButton.icon(
                onPressed: () async {
                  await fileUploadController.downloadAndDecryptFile(
                      record.pdfUrl!, record.nik!);
                },
                label: const Text('View PDF'),
                icon: const Icon(Icons.picture_as_pdf_rounded)),
            const SizedBox(height: 16.0),
            FilledButton.icon(
              onPressed: () {
                Get.toNamed('/request', arguments: record);
              },
              label: const Text('Ajukan Peminjaman Data'),
              icon: const Icon(Icons.download_for_offline_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
