import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color hintColor;
  final FontWeight hintFontWeight;  
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final int maxLines;
  final InputBorder border;
  final InputBorder focusBorder;
  final InputBorder errorBorder;
  final InputBorder focusedErrorBorder;
  final FormFieldValidator<String>? validator; // Make the validator optional

  const TextFormInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.hintColor = AppColorConstant.black,
    this.hintFontWeight = FontWeight.w600,
    this.textAlign = TextAlign.center,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.border = InputBorder.none,
    this.focusBorder = InputBorder.none,
    this.errorBorder = InputBorder.none,
    this.focusedErrorBorder = InputBorder.none,
    this.validator, // Provide a default value of null
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        // inputFormatters: [],
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
                ? hintColor
                : AppColorConstant.black.withOpacity(0.6),
            fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 16,
            fontWeight: FontWeight.normal,
          ),
          border: border,
          focusedBorder: focusBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
          // focusColor: AppColorConstant.subHeadingColor,
        ),
        validator: validator, // Apply the validator conditionally
      ),
    ]);
  }
}
