import 'package:flutter/material.dart';

class CustomTextfild extends StatelessWidget {
  const CustomTextfild({
    super.key,
    required this.controller,
    required this.hintext,
    required this.icon,
    required this.validate,

  });

  final TextEditingController controller;
  final String hintext;
  final IconData icon;
  final String? Function(String?) validate;



  @override
  // void initState() {
  //   super.initState();
  //   visible = widget.obscureText;
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: controller,
      decoration: InputDecoration(
        fillColor:  Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)),
        prefixIcon:Icon(icon) ,
        hintText: hintext,
      ),
    );
  }
}
