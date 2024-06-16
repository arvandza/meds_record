import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/user_controller.dart';

class ListScreen extends StatelessWidget {
  ListScreen({super.key}) {
    // Inisialisasi UserController secara lazy
    Get.lazyPut<UserController>(() => UserController());
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Scaffold(body: Obx(() {
      if (userController.requestRecord.isEmpty) {
        return const Center(child: Text('No Request List Found'));
      } else {
        return ListView.builder(
            itemCount: userController.requestRecord.length,
            itemBuilder: (context, index) {
              final requestRecord = userController.requestRecord[index];
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
                  title: Text(requestRecord.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Instansi: ${requestRecord.instansiName}'),
                      Text('Keperluan: ${requestRecord.keperluan}'),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade500,
                    size: 16,
                  ),
                  onTap: () async {
                    await userController.listenToRequestMedicalRecord(
                        requestRecord.medicalRecordId);
                    Get.offAndToNamed('/list-details',
                        arguments: requestRecord);
                  },
                ),
              );
            });
      }
    }));
  }
}
