import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/modules/home/controllers/request_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_button.dart';

class RequestView extends StatelessWidget {
  RequestView({super.key});

  final TextEditingController namaController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController instansiController = TextEditingController();
  final TextEditingController keperluanController = TextEditingController();

  final AccessRequestController requestController =
      Get.put(AccessRequestController());

  final MedicalrecordModel record = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Request Permintaan'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Ajukan Permintaan',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(height: 32),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                    hintText: 'Nama peminta',
                    labelText: 'Nama Peminta',
                    prefixIcon: Icon(Icons.person_2_rounded)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nikController,
                decoration: const InputDecoration(
                    hintText: 'NIK peminta',
                    labelText: 'NIK Peminta',
                    prefixIcon: Icon(Icons.perm_identity_rounded)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: instansiController,
                decoration: const InputDecoration(
                    hintText: 'Nama Instansi',
                    labelText: 'Instansi Peminta',
                    prefixIcon: Icon(Icons.home_work_rounded)),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: keperluanController,
                decoration: const InputDecoration(
                    hintText: 'Keperluan',
                    labelText: 'Keperluan',
                    prefixIcon: Icon(Icons.pending_actions_rounded)),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return CustomButton(
                  isLoading: requestController.isLoading.value,
                  text: 'Ajukan Permintaan',
                  onPressed: () {
                    requestController.requestAccess(
                        nikController.text,
                        instansiController.text,
                        keperluanController.text,
                        namaController.text,
                        record.recordId!,
                        record.patientId!);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
