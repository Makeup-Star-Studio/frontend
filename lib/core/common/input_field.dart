import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final int maxLines;
  final InputBorder border;
  final InputBorder focusBorder;
  final FormFieldValidator<String>? validator; // Make the validator optional

  const TextFormInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textAlign = TextAlign.center,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.border = InputBorder.none,
    this.focusBorder = InputBorder.none,
    this.validator, // Provide a default value of null
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        textAlign: textAlign,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          filled: true,
          fillColor: AppColorConstant.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColorConstant.black.withOpacity(0.6),
            fontSize: 14.0,
          ),
          border: border,
          focusedBorder: focusBorder,
          focusColor: AppColorConstant.black,
        ),
        validator: validator, // Apply the validator conditionally
      ),
    ]);
  }
}
