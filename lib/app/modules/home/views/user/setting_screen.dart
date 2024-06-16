import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/auth_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ListView(
            children: [
              _buildMenuItem('Change Key', Icons.key_rounded, onTap: () {
                Get.toNamed('/changekey');
              }),
              const Divider(
                color: Colors.black12,
                thickness: 0.1,
              ),
              _buildMenuItem('Logout', Icons.logout_rounded, onTap: () {
                authController.logout();
              }),
              const Divider(
                color: Colors.black12,
                thickness: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      title: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      leading: Icon(icon, color: Colors.grey),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
