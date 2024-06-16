import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final String? description;
  final String? randomVar;
  final VoidCallback onPressed;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.buttonText,
      this.description,
      this.randomVar,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      content: description == null ? null : Text('$description ${randomVar!}'),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
