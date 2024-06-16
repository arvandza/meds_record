import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controllers/navigation_controller.dart';

class CustomBottomAdminNavbar extends StatelessWidget {
  final BottomNavigationController _controller =
      Get.put(BottomNavigationController());

  CustomBottomAdminNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SalomonBottomBar(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          unselectedItemColor: Colors.black54,
          currentIndex: _controller.selectedIndex.value,
          onTap: (index) => _controller.changePage(index),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text('Home'),
                selectedColor: Colors.blue),
            SalomonBottomBarItem(
                icon: const Icon(Icons.people_alt_rounded),
                title: const Text('Patient'),
                selectedColor: Colors.blue),
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Setting'),
                selectedColor: Colors.blue),
          ],
        ));
  }
}
