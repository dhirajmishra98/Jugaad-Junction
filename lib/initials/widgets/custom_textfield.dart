import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.controller,
      required this.labelText,
      this.isPasswordField = false,
      super.key});
  final TextEditingController controller;
  final String labelText;
  final bool isPasswordField;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isVisible = true;

  _toggleVisiblity() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? isVisible : false,
      decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  onPressed: _toggleVisiblity,
                  icon: isVisible
                      ? const Icon(Remix.eye_off_fill)
                      : const Icon(Remix.eye_fill),
                )
              : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your ${widget.labelText}';
        }
        return null;
      },
    );
  }
}
