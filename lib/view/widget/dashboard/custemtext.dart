import 'package:flutter/material.dart';
import '../../../core/my_function/validinput.dart';
class custemtext extends StatelessWidget {
  final control;
  final hint;
  const custemtext({super.key, this.control, this.hint});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: control,
        validator: (v) {
         return validinput(v!, 3, 100,"", "");
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hint,
            prefixIcon: const Icon(Icons.category)
        ),
      ),
    );
  }
}
