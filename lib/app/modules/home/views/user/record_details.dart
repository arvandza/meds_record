import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/fileupload_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_card.dart';

import '../../../../data/models/medicalrecord_model.dart';

class RecordDetails extends StatelessWidget {
  RecordDetails({super.key});

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
                icon: const Icon(Icons.picture_as_pdf_rounded))
          ],
        ),
      ),
    );
  }
}
