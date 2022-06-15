import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String placeholder;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  const InputTextField({
    Key? key,
    this.placeholder = "Enter value",
    this.textInputAction,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      controller: controller,
      decoration: InputDecoration(
        labelText: placeholder,
      ),
      keyboardType: TextInputType.text,
    );
  }
}
