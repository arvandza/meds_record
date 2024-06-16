import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/user_controller.dart';

class RecordScreen extends StatelessWidget {
  RecordScreen({super.key}) {
    Get.lazyPut<UserController>(() => UserController());
  }

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    return Scaffold(body: Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.medicalRecord.isEmpty) {
          return const Center(child: Text('No Medical Records Found'));
        } else {
          return ListView.builder(
              itemCount: controller.medicalRecord.length,
              itemBuilder: (context, index) {
                final record = controller.medicalRecord[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.blue, // Warna border bawah
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
                    title: Text(record.name!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('No. Rekam Medis: ${record.recordNumber}'),
                        Text(
                            'Tanggal Berobat: ${record.date!.day}-${record.date!.month}-${record.date!.year}'),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade500,
                      size: 16,
                    ),
                    onTap: () {
                      Get.toNamed('/recorddetails', arguments: record);
                    },
                  ),
                );
              });
        }
      },
    ));
  }
}
