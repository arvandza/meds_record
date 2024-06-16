import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/navigation_controller.dart';
import 'package:meds_record/app/modules/home/views/user/home_screen.dart';
import 'package:meds_record/app/modules/home/views/user/list_screen.dart';
import 'package:meds_record/app/modules/home/views/user/record_screen.dart';
import 'package:meds_record/app/modules/home/views/user/setting_screen.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_bottomnavbar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final BottomNavigationController _controller =
      Get.put(BottomNavigationController());

  final List<Widget> _pages = [
    HomeScreen(),
    RecordScreen(),
    ListScreen(),
    SettingScreen(),
  ];

  final List<String> _pageTitles = [
    'Home',
    'My Record',
    'List',
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
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}
