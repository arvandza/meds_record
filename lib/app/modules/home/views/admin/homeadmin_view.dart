import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/views/admin/homeadmin_screen.dart';
import 'package:meds_record/app/modules/home/views/admin/patient_view.dart';
import 'package:meds_record/app/modules/home/views/admin/settingadmin_screen.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_bottomadminnavbar.dart';

import '../../controllers/navigation_controller.dart';

class HomeAdminView extends StatelessWidget {
  HomeAdminView({super.key});

  final BottomNavigationController _controller =
      Get.put(BottomNavigationController());

  final List<Widget> _pages = [
    HomeAdminScreen(),
    PatientView(),
    SettingScreen()
  ];

  final List<String> _pageTitles = [
    'Home',
    'Patient',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => Text(
              _pageTitles[_controller.selectedIndex.value],
              style: const TextStyle(fontWeight: FontWeight.w500),
            )),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Obx(
            () => _pages[_controller.selectedIndex.value],
          )),
      bottomNavigationBar: CustomBottomAdminNavbar(),
    );
  }
}
