import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/auth_controller.dart';
import 'package:meds_record/app/modules/home/controllers/form_controller.dart';
import 'package:meds_record/app/modules/home/views/widget/custom_textfield.dart';
import 'package:meds_record/app/utils/imageprodiver.dart';

import '../widget/custom_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final FormController formController = Get.put(FormController());

  final AuthController authController = Get.put(AuthController());

  final TextEditingController nikController = TextEditingController();

  final TextEditingController emailControlller = TextEditingController();

  @override
  void dispose() {
    nikController.dispose();
    emailControlller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: Images().imageProvider),
            const SizedBox(height: 72),
            CustomTextField(
              controller: nikController,
              labelText: 'NIK',
              hintText: 'Enter your NIK',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.perm_identity,
              onChanged: (value) {
                formController.numberId.value = value;
                formController.validateNumberId(value);
              },
              errorText: formController.numberIdError,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: emailControlller,
              labelText: 'Email',
              hintText: 'Enter your Email',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              onChanged: (value) {
                formController.email.value = value;
                formController.validateEmail(value);
              },
              errorText: formController.emailError,
            ),
            const SizedBox(height: 28),
            Obx(
              () => CustomButton(
                text: 'Create a new Key',
                onPressed: () {
                  authController.registerPatient(
                      emailControlller.text, nikController.text);
                  nikController.clear();
                  emailControlller.clear();
                },
                isLoading: authController.isLoading.value,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun?'),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration page
                    Get.offAllNamed('/login');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
