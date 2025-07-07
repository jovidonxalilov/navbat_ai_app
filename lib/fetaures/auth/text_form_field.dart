import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final bool hideText;
  final TextEditingController? controller;
  final  Color colorStyle;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const MyTextFormField({
    super.key,
    this.keyboardType = TextInputType.text,
    this.colorStyle = Colors.white,
    this.hintText,
    this.controller,
    this.hideText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: colorStyle, fontSize: 15),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
