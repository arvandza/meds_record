import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/auth_controller.dart';
import 'package:meds_record/app/modules/home/controllers/form_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_textfield.dart';

import '../widget/custom_button.dart';

class ChangeKeyView extends StatefulWidget {
  const ChangeKeyView({super.key});

  @override
  State<ChangeKeyView> createState() => _ChangeKeyViewState();
}

class _ChangeKeyViewState extends State<ChangeKeyView> {
  TextEditingController nikController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController reEnterController = TextEditingController();

  final FormController formController = Get.put(FormController());

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Key'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            CustomTextField(
              prefixIcon: Icons.perm_identity,
              controller: nikController,
              onChanged: (value) {
                formController.nik.value = value;
                formController.isEmpty(value, 'NIK cant be empty');
              },
              errorText: formController.nikError,
              hintText: 'Enter NIK',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              prefixIcon: Icons.email_rounded,
              controller: emailController,
              onChanged: (value) {
                formController.email.value = value;
                formController.validateEmail(value);
              },
              errorText: formController.emailError,
              hintText: 'Enter Email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              prefixIcon: Icons.key_rounded,
              controller: oldPasswordController,
              onChanged: (value) {
                formController.oldPassword.value = value;
                formController.isEmpty(value, 'Key cant be empty');
              },
              errorText: formController.oldPasswordError,
              hintText: 'Enter your Old Key',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              prefixIcon: Icons.key_rounded,
              controller: reEnterController,
              onChanged: (value) {
                formController.reEnterPassword.value = value;
                formController.validatePasswords();
              },
              errorText: formController.passwordError,
              hintText: 'Re-enter your Old key',
            ),
            const SizedBox(height: 24),
            Obx(
              () => CustomButton(
                isLoading: authController.isLoading.value,
                text: 'Create a new Key',
                onPressed: () {
                  User? user = authController.auth.currentUser;
                  authController.updatePassword(
                      user!.uid, reEnterController.text);
                  reEnterController.clear();
                  emailController.clear();
                  oldPasswordController.clear();
                  nikController.clear();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
