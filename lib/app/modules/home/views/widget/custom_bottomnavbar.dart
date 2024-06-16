import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:meds_record/app/modules/home/controllers/navigation_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  final BottomNavigationController _controller =
      Get.put(BottomNavigationController());

  CustomBottomNavbar({super.key});

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
                icon: const Icon(Icons.location_history_rounded),
                title: const Text('My Record'),
                selectedColor: Colors.blue),
            SalomonBottomBarItem(
                icon: const Icon(Icons.my_library_books_rounded),
                title: const Text('List'),
                selectedColor: Colors.blue),
            SalomonBottomBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Setting'),
                selectedColor: Colors.blue),
          ],
        ));
  }
}
