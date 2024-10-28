import 'package:flutter/material.dart';

class customtextfaild extends StatefulWidget {
  final hint;
  final icon;
  final checkpass;
  final TextInputType typeinput;
  final String? Function(String?) valid;
  final ValueChanged<String>? chech;
  final TextEditingController controller;
  const customtextfaild(
      {super.key,
      this.hint,
      this.icon,
      this.checkpass,
      required this.controller,
      required this.typeinput,
      required this.valid,
      this.chech});
  @override
  State<customtextfaild> createState() => _customtextfaildState();
}

class _customtextfaildState extends State<customtextfaild> {
  late bool showpass;
  late final String? Function(String?) v;
  late final String? Function(String?) check;

  @override
  void initState() {
    showpass = widget.checkpass;
    v = widget.valid;
    // check=widget.chech;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: v,
      onChanged: widget.chech,
      obscureText: showpass,
      keyboardType: widget.typeinput,
      decoration: InputDecoration(
          // hintText: widget.hint,
          label: Text(widget.hint),
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.checkpass == true
              ? showpass == true
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          if (showpass == true) {
                            showpass = false;
                          } else {
                            showpass = true;
                          }
                        });
                      },
                      icon: const Icon(Icons.visibility))
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          if (showpass == true) {
                            showpass = false;
                          } else {
                            showpass = true;
                          }
                        });
                      },
                      icon: const Icon(Icons.visibility_off))
              : const SizedBox(
                  width: 2,
                  height: 2,
                ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          )),
    );
  }
}
