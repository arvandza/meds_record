import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/medicalrecord_model.dart';
import 'package:meds_record/app/modules/home/controllers/datepicker_controller.dart';
import 'package:meds_record/app/modules/home/controllers/fileupload_controller.dart';
import 'package:meds_record/app/modules/home/controllers/medicalrecord_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_textfield.dart';

import '../../controllers/form_controller.dart';
import '../widget/custom_button.dart';

class AddRecordView extends StatefulWidget {
  const AddRecordView({super.key});

  @override
  State<AddRecordView> createState() => _AddRecordViewState();
}

class _AddRecordViewState extends State<AddRecordView> {
  final TextEditingController namaController = TextEditingController();

  final TextEditingController nikController = TextEditingController();

  final TextEditingController lokasiController = TextEditingController();

  final TextEditingController riwayatController = TextEditingController();

  final TextEditingController diagnosaController = TextEditingController();

  TextEditingController noRekamController = TextEditingController();

  final FormController formController = Get.put(FormController());

  final DatePickerController dateController = Get.put(DatePickerController());

  final FileUploadController fileUploadController =
      Get.put(FileUploadController());

  final MedicalRecordController medicalRecordController =
      Get.put(MedicalRecordController());

  @override
  void initState() {
    super.initState();
    noRekamController = TextEditingController(
        text: formController.generatedMedicalRecordNumber());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Upload Patient Record'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('No.Rekam Medis'),
              CustomTextField(
                prefixIcon: Icons.recent_actors_rounded,
                controller: noRekamController,
                onChanged: (value) {
                  formController.noRekam.value = value;
                  formController.validateNoRekam(
                      value, 'No.Rekam cant be empty');
                },
                errorText: formController.noRekamError,
                isEnable: false,
              ),
              const SizedBox(height: 16),
              const Text('Nama Pasien*'),
              CustomTextField(
                prefixIcon: Icons.person_2_rounded,
                controller: namaController,
                hintText: 'Masukkan Nama Pasien',
                onChanged: (value) {
                  formController.name.value = value;
                  formController.validateName(value, 'Nama cant be empty');
                },
                errorText: formController.nameError,
              ),
              const SizedBox(height: 16),
              const Text('NIK*'),
              CustomTextField(
                prefixIcon: Icons.chrome_reader_mode_rounded,
                controller: nikController,
                keyboardType: TextInputType.number,
                hintText: 'Masukkan NIK Pasien',
                onChanged: (value) {
                  formController.nik.value = value;
                  formController.validateNik(value, 'NIK cant be empty');
                },
                errorText: formController.nikError,
              ),
              const SizedBox(height: 16),
              const Text('Tanggal*'),
              Obx(() {
                return TextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: "${dateController.selectedDate.value.toLocal()}"
                        .split(' ')[0],
                  ),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range_rounded,
                          color: Colors.black54),
                      hintText: 'Pilih Tanggal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Colors.red)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: Color(0xFF097EDA))),
                      fillColor: Colors.grey.shade100,
                      filled: true),
                  onTap: () => dateController.pickDate(context),
                );
              }),
              const SizedBox(height: 16),
              const Text('Lokasi'),
              CustomTextField(
                prefixIcon: Icons.location_on_rounded,
                controller: lokasiController,
                hintText: 'Rumah Sakit/Puskesmas',
                onChanged: (value) {
                  formController.location.value = value;
                  formController.validateLocation(
                      value, 'Location cant be empty');
                },
                errorText: formController.locationError,
              ),
              const SizedBox(height: 16),
              const Text('Riwayat Penyakit*'),
              CustomTextField(
                prefixIcon: Icons.location_history_rounded,
                controller: riwayatController,
                hintText: 'Contoh: Asma',
                onChanged: (value) {
                  formController.riwayat.value = value;
                  formController.validateHistory(
                      value, 'Riwayat cant be empty');
                },
                errorText: formController.riwayatError,
              ),
              const SizedBox(height: 16),
              const Text('Diagnosa'),
              CustomTextField(
                prefixIcon: Icons.note_alt_rounded,
                controller: diagnosaController,
                hintText: 'Contoh: Penyakit Paru-Paru',
                onChanged: (value) {
                  formController.diagnosis.value = value;
                  formController.validateDiagnosis(
                      value, 'Diagnosis cant be empty');
                },
                errorText: formController.diagnosisError,
              ),
              const SizedBox(height: 16),
              const Text('Upload File'),
              GestureDetector(
                onTap: fileUploadController.selectedFile.value == null
                    ? fileUploadController.pickFile
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Obx(() {
                    return fileUploadController.selectedFile.value == null
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, color: Colors.lightBlue),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Upload File PDF',
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  fileUploadController.selectedFile.value!.name,
                                  style: const TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.cancel, color: Colors.red),
                                onPressed: fileUploadController.removeFile,
                              ),
                            ],
                          );
                  }),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return Checkbox(
                        value: formController.isChecked.value,
                        onChanged: (bool? value) {
                          formController.isChecked.value = value ?? false;
                        });
                  }),
                  const Text('Data yang saya isikan sudah benar'),
                ],
              ),
              const SizedBox(height: 28),
              Obx(
                () => CustomButton(
                  isLoading: medicalRecordController.isLoading.value,
                  text: 'Save',
                  onPressed: () async {
                    if (formController.isFormValid.value) {
                      final record = MedicalrecordModel(
                          recordId: '',
                          name: namaController.text,
                          nik: nikController.text,
                          date: dateController.selectedDate.value,
                          diseaseHistory: riwayatController.text,
                          diagnosis: diagnosaController.text,
                          location: lokasiController.text,
                          patientId: '',
                          recordNumber: noRekamController.text,
                          pdfUrl: '',
                          publicKey: '',
                          aesKey: '',
                          macBytes: '',
                          aesNonce: '',
                          cipherText: '');
                      await medicalRecordController.saveRecord(
                          record, fileUploadController.selectedFile.value!);

                      namaController.clear();
                      nikController.clear();
                      riwayatController.clear();
                      diagnosaController.clear();
                      lokasiController.clear();
                      fileUploadController.selectedFile.value = null;
                    } else {
                      print('Form is invalid');
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
