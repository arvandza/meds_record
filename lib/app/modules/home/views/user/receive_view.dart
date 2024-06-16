import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/user_controller.dart';

class ReceiveView extends StatefulWidget {
  const ReceiveView({super.key});

  @override
  State<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Receive'),
          centerTitle: true,
        ),
        body: Obx(
          () {
            if (controller.approvedRecord.isEmpty) {
              return const Center(child: Text('No Approved Record'));
            }
            return ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                itemCount: controller.approvedRecord.length,
                itemBuilder: (context, index) {
                  final record = controller.approvedRecord[index];
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
                        Get.toNamed('/receive-details', arguments: record);
                      },
                    ),
                  );
                });
          },
        ));
  }
}
