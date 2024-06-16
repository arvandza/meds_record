import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController {
  var selectedDate = DateTime.now().obs;

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
