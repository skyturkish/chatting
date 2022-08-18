import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.textInputType,
      required this.hintText,
      this.obscureText = false})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
    );
  }
}
