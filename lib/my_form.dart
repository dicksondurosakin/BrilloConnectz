import 'package:flutter/material.dart';

// This widget will be used to create multiple form
class MyForm extends StatelessWidget {
  const MyForm({
    Key? key,
    required this.text,
    required this.hint,
    this.validator,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
  }) : super(key: key);
  final String text;
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            maxLength: maxLength,
            obscureText: obscureText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hint,
            ),
            keyboardType: keyboardType,
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
