import 'package:flutter/material.dart';

class TextFieldSearch extends StatelessWidget {
  final void Function()? onPressedSearch;
  final void Function(String)? onChanged;
  final TextEditingController? mycontroller;
  const TextFieldSearch({
    super.key,
    this.onPressedSearch,
    this.onChanged,
    this.mycontroller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mycontroller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: IconButton(
            onPressed: onPressedSearch,
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 113, 176, 227))),
        suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
        hintText: 'Search any Product..',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
