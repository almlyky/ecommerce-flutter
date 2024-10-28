import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 10),
                    color: Colors.grey[300],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    height: 40,
                    padding: const EdgeInsets.only(bottom: 3, top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 70,
                            ),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      'Create your account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),

                  const Text(
                    "name",
                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 7),
                  // Name field
                  CustumTextField(
                    controller: _nameController,
                    icon: Icons.person,
                    hintText: 'input your name',
                    validator: (value) {
                    return validinput(value!, 6, 100, "username", "");
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Phone",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 5),

                  // Phone field
                  CustumTextField(
                    controller: _phoneController,
                    icon: Icons.phone,
                    hintText: 'input your phone',
                    validator: (value) {
                    return validinput(value!, 9, 9, "phone", "");
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Email",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 5),

                  CustumTextField(
                    controller: _emailController,
                    icon: Icons.email,
                    hintText: 'email@example.com',
                    validator: (value) {
                     return validinput(value!, 6, 100, "email", "");
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "password",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 5),

                  CustumTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    hintText: 'input your password',
                    obscureText: true,
                    validator: (value) {
                   return validinput(value!, 6, 100, "username", "");
                    },
                    suffixIcon:
                        Icons.visibility, // Eye icon for password visibility
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 160, vertical: 1),
                        backgroundColor: Colors.blue, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                      child: Text(
                    'or Sign Up with',
                    style: TextStyle(color: Colors.black54),
                  )),
                  const SizedBox(height: 5),
                  // Google Sign Up
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
                            height: 50,
                            width: 50,
                          ),
                          iconSize: 50,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png',
                            height: 50,
                            width: 50,
                          ),
                          iconSize: 50,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustumTextField extends StatelessWidget {
  final bool obscureText;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final String? Function(String?) validator;
  const CustumTextField(
      {super.key,
      required this.controller,
      required this.icon,
      required this.hintText,
      required this.validator,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        fillColor: Colors.grey[200],
        prefixIcon: Icon(icon),
        hintStyle: TextStyle(color: Colors.grey[500]),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}


validinput(String val, int min, int max, String type, String error) {
  if (val.isEmpty) {
    return "cann't be empty";
  }
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "not valid username";
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    } else if ((error == "sign")) {
      return "the email is exist alredy";
    } else if (error == "login") {
      return "the acounts is not found";
    }
  }
  if (val.length < min) {
    return "cann't be less than $min";
  }
  if (val.length > max) {
    return "can't be larger than $max";
  }
}
