import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/data/models/accessrequest_model.dart';
import 'package:meds_record/app/modules/home/controllers/user_controller.dart';

import '../../controllers/fileupload_controller.dart';
import '../widget/custom_card.dart';

class ListDetails extends StatefulWidget {
  const ListDetails({super.key});

  @override
  State<ListDetails> createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  final UserController controller = Get.put(UserController());
  final FileUploadController fileUploadController =
      Get.put(FileUploadController());

  AccessRequestModel requestModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Details'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAndToNamed('/main');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildRequestMedicalRecordSection(context),
            const SizedBox(height: 16.0),
            CustomCard.buildPersonalDetails(controller.reqRecord[0]),
            const SizedBox(height: 16.0),
            CustomCard.buildMedicalHistory(controller.reqRecord[0]),
            const SizedBox(height: 32.0),
            FilledButton.icon(
              onPressed: () async {
                await fileUploadController.downloadAndDecryptFile(
                    controller.reqRecord[0].pdfUrl!,
                    controller.reqRecord[0].nik!);
              },
              label: const Text('View PDF'),
              icon: const Icon(Icons.picture_as_pdf_rounded),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestMedicalRecordSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            '${requestModel.name} Ingin Meminjam Data Rekam Medismu, Terima?',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  _showResponseConfirmation(context, 'approved');
                },
                label: const Text('Iya'),
                icon: const Icon(Icons.check),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    minimumSize: WidgetStateProperty.all(const Size(32, 38))),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: FilledButton.icon(
                onPressed: () {
                  _showResponseConfirmation(context, 'denied');
                },
                label: const Text('Tidak'),
                icon: const Icon(Icons.close),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    minimumSize: WidgetStateProperty.all(const Size(32, 38))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showResponseConfirmation(BuildContext context, String response) {
    String message = response == 'approved'
        ? 'Anda yakin ingin memberikan data anda kepada ${requestModel.name!}?'
        : 'Anda Menolak Permintaan';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: response == 'approved'
              ? const Text('Anda yakin?')
              : const Text('Anda Menolak Permintaan'),
          content: Text(message),
          actions: [
            response == 'approved'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.acceptRequest(requestModel.requestId!);
                          Navigator.of(context).pop();
                          controller.requestRecord.value = [];
                        },
                        child: const Text('Yakin'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Tidak'),
                      ),
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      controller.deniedRequest(requestModel.requestId!);
                      Navigator.of(context).pop();
                      controller.requestRecord.value = [];
                    },
                    child: const Text('OK'),
                  ),
          ],
        );
      },
    );
  }
}
