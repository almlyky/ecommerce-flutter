import 'package:flutter/material.dart';
class custombuttonlogin extends StatelessWidget {
  final textbutton;
  const custombuttonlogin({
    super.key, this.textbutton,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
        onPressed: (){

        }, child: Text(textbutton,style: const TextStyle(fontSize: 20),)
    );
  }
}