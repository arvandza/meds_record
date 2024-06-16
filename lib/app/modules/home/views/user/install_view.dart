import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_button.dart';

class InstallView extends StatelessWidget {
  const InstallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 128),
            CustomButton(
                text: 'Login with Key',
                onPressed: () {
                  Get.toNamed('/login');
                }),
            const SizedBox(height: 28),
            CustomButton(
                text: 'Create new Key',
                onPressed: () {
                  Get.toNamed('/register');
                }),
          ],
        ),
      ),
    );
  }
}
