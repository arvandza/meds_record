import 'dart:math';
import 'package:get/get.dart';

class FormController extends GetxController {
  var email = ''.obs;
  var emailError = ''.obs;
  var numberId = ''.obs;
  var numberIdError = ''.obs;
  var key = ''.obs;
  var keyError = ''.obs;
  var isLoading = false.obs;
  var nik = ''.obs;
  var nikError = ''.obs;
  var name = ''.obs;
  var nameError = ''.obs;
  var location = ''.obs;
  var locationError = ''.obs;
  var diagnosis = ''.obs;
  var diagnosisError = ''.obs;
  var noRekam = ''.obs;
  var noRekamError = ''.obs;
  var riwayat = ''.obs;
  var riwayatError = ''.obs;
  var oldPassword = ''.obs;
  var reEnterPassword = ''.obs;
  var passwordError = ''.obs;
  var oldPasswordError = ''.obs;

  RxBool isChecked = false.obs;
  RxBool isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(isChecked, (_) => _validateForm());
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter an email';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Please enter a valid email';
    } else {
      emailError.value = '';
    }
  }

  void validateNumberId(String value) {
    if (value.isEmpty) {
      numberIdError.value = 'Please enter an NIK';
    } else if (!GetUtils.isNum(value)) {
      numberIdError.value = 'Please enter a valid NIK';
    } else {
      numberIdError.value = '';
    }
  }

  void isEmpty(String value, String message) {
    if (value.isEmpty) {
      keyError.value = message;
    } else {
      keyError.value = '';
    }
  }

  String generatedRandomKey(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void validateNik(String value, String message) {
    if (value.isEmpty) {
      nikError.value = message;
    } else {
      nikError.value = '';
    }
  }

  void validateName(String value, String message) {
    if (value.isEmpty) {
      nameError.value = message;
    } else {
      nameError.value = '';
    }
  }

  void validateLocation(String value, String message) {
    if (value.isEmpty) {
      locationError.value = message;
    } else {
      locationError.value = '';
    }
  }

  void validateDiagnosis(String value, String message) {
    if (value.isEmpty) {
      diagnosisError.value = message;
    } else {
      diagnosisError.value = '';
    }
  }

  void validateHistory(String value, String message) {
    if (value.isEmpty) {
      riwayatError.value = message;
    } else {
      riwayatError.value = '';
    }
  }

  void validateNoRekam(String value, String message) {
    if (value.isEmpty) {
      noRekamError.value = message;
    } else {
      noRekamError.value = '';
    }
  }

  String generatedMedicalRecordNumber() {
    String prefix = 'MR';
    String currentDate =
        DateTime.now().toString().substring(0, 10).replaceAll('-', '');

    int randomNumber = Random().nextInt(9000) + 1000;

    String medicalRecordNumber = '$prefix$currentDate$randomNumber';
    return medicalRecordNumber;
  }

  void _validateForm() {
    if (isChecked.value) {
      isFormValid.value = true;
    } else {
      isFormValid.value = false;
    }
  }

  void validatePasswords() {
    if (reEnterPassword.value != oldPassword.value) {
      passwordError.value = 'Passwords do not match';
    } else {
      passwordError.value = '';
    }
  }
}
