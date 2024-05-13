import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

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
        cursorColor: AppColorConstant.black.withOpacity(0.6),
        maxLines: maxLines,
        decoration: InputDecoration(
          hoverColor: Colors.transparent,
          filled: true,
          fillColor: AppColorConstant.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: ResponsiveWidget.isSmallScreen(context)
                ? AppColorConstant.black
                : AppColorConstant.black.withOpacity(0.6),
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
            fontWeight: ResponsiveWidget.isSmallScreen(context)
                ? FontWeight.w600
                : FontWeight.normal,
          ),
          border: border,
          focusedBorder: focusBorder,
          // focusColor: AppColorConstant.subHeadingColor,
        ),
        validator: validator, // Apply the validator conditionally
      ),
    ]);
  }
}
