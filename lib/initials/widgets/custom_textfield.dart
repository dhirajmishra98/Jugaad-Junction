import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:remixicon/remixicon.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.controller,
      required this.labelText,
      this.isPasswordField = false,
      this.maxLines = 1,
      super.key});
  final TextEditingController controller;
  final String labelText;
  final bool isPasswordField;
  final int maxLines;

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
      maxLines: widget.maxLines,
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
            borderSide: BorderSide(color: GlobalVariables.secondaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: GlobalVariables.secondaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: GlobalVariables.secondaryColor),
          ),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: GlobalVariables.secondaryColor,
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
