import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meds_record/app/modules/home/controllers/auth_controller.dart';

import '../../../../utils/imageprodiver.dart';
import '../../controllers/form_controller.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final FormController formController = Get.put(FormController());
  final AuthController authController = Get.put(AuthController());
  final TextEditingController keyController = TextEditingController();

  @override
  void dispose() {
    keyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: Images().imageProvider),
            const SizedBox(height: 128),
            CustomTextField(
                obscureText: true,
                controller: keyController,
                labelText: 'KEY',
                hintText: 'Enter your Key',
                keyboardType: TextInputType.text,
                prefixIcon: Icons.key,
                onChanged: (value) {
                  formController.key.value = value;
                  formController.isEmpty(value, 'Key cant be empty');
                },
                errorText: formController.keyError),
            const SizedBox(height: 28),
            Obx(() {
              return CustomButton(
                  isLoading: authController.isLoading.value,
                  text: 'Login',
                  onPressed: () async {
                    bool loginSuccess =
                        await authController.login(keyController.text);
                    if (loginSuccess) {
                      if (authController.userRole.value == 'admin') {
                        Get.offAllNamed('/adminhome');
                      } else if (authController.userRole.value == 'patient') {
                        Get.offAllNamed('/main');
                      }
                    }
                  });
            }),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Belum punya akun?'),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration page
                    Get.offAllNamed('/register');
                  },
                  child: const Text(
                    'Register',
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
