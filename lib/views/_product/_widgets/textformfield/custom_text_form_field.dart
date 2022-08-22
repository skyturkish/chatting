import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.textInputType,
      required this.hintText,
      this.labelText,
      this.autoFocus,
      this.obscureText = false,
      this.enableSuggestions})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType? textInputType;
  final String hintText;
  final bool obscureText;
  final String? labelText;
  final bool? autoFocus;
  final bool? enableSuggestions;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final labelText = widget.labelText ?? widget.hintText;

    return TextFormField(
      controller: widget.controller,
      enableSuggestions: widget.enableSuggestions ?? false,
      autocorrect: false,
      autofocus: widget.autoFocus ?? false,
      textInputAction: TextInputAction.next,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType ?? TextInputType.name,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
    );
  }
}
