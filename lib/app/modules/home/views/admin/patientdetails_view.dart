import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/medicalrecord_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_card.dart';

class PatientDetails extends StatefulWidget {
  const PatientDetails({super.key});

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  final MedicalRecordController medicalRecordController =
      Get.put(MedicalRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Record Details'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAllNamed('/adminhome');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (medicalRecordController.medicalRecord.isNotEmpty)
              CustomCard.buildPersonalDetails(
                medicalRecordController.medicalRecord[0],
              ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Obx(() {
                if (medicalRecordController.medicalRecord.isEmpty) {
                  return const Center(
                      child: Text('Belum Ada Riwayat Kesehatan'));
                }
                return ListView.builder(
                  itemCount: medicalRecordController.medicalRecord.length,
                  itemBuilder: (context, index) {
                    final record = medicalRecordController.medicalRecord[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.lightBlue, // Warna border bawah
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Text(
                          record.recordNumber!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tanggal: ${record.date!.day}-${record.date!.month}-${record.date!.year}',
                            ),
                            Text('Lokasi: ${record.location}'),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ),
                        onTap: () {
                          Get.toNamed('/patientdetails2', arguments: record);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 32.0),
            FilledButton.icon(
              onPressed: () {
                Get.offNamed('/addrecord');
              },
              label: const Text('Upload PDF'),
              icon: const Icon(Icons.upload),
            ),
          ],
        ),
      ),
    );
  }
}
