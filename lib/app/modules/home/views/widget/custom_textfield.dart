import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final RxString? errorText;
  final String? initValue;
  final bool? isEnable;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.errorText,
    this.initValue,
    this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        initialValue: initValue,
        enabled: isEnable,
        decoration: InputDecoration(
          errorText: errorText?.value.isEmpty ?? true ? null : errorText?.value,
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: Colors.black54,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.black54)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xFF097EDA)),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
        ),
      );
    });
  }
}
