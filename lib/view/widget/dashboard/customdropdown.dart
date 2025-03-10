import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controler/dashboard/dashhomecontroller.dart';
import '../../../controler/homepagecontroler.dart';

class customdropdown extends StatelessWidget {
  final void Function(Object?)? onChanged;
  final String? value;
  final List datadrop;
  const customdropdown(
      {super.key, this.value, required this.datadrop, this.onChanged});

  @override
  Widget build(BuildContext context) {
    homepagecontrolerimp controller = Get.find();
    return DropdownButton(
      value: value,
      items: controller.catName
          .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
          .toList(),
      onChanged: onChanged,
    );
  }
}
