import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Authphone extends StatelessWidget {
  const Authphone({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth =FirebaseAuth.instance;
    return Scaffold(appBar: AppBar(title: const Text("Auth Phone"),),
    body: Column(children: [
      TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          )
        ),
      ),
      ElevatedButton(onPressed: ()async{
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+967773880270',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            print("error message auth ===============${e.message}");
          },
          codeSent: (String verificationId, int? resendToken) {
            print("successfuly send==================");
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      }, child: const Text("Send sms"))
    ],),
    );
  }
}
