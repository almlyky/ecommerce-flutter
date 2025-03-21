import 'package:flutter/material.dart';

class CustomTextfild extends StatelessWidget {
  const CustomTextfild({
    super.key,
    required this.controller,
    required this.hintext,
    required this.icon,
    required this.validate, required this.textInputType,
  });

  final TextEditingController controller;
  final String hintext;
  final IconData icon;
  final String? Function(String?) validate;
  final TextInputType textInputType;

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon),
        hintText: hintext,
      ),
    );
  }
}
