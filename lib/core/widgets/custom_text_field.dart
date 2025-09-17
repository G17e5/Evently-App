import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.isSecure = false,
    required this.validator,
    required this.controller,
  });

  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool isSecure;
  final String? Function(String?) validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isSecure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
        suffixIcon: suffixIcon,
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}
