import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';

class BookingInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool isTextRequired;
  final bool isFormFieldRequired;
  final InputBorder border;
  final InputBorder focusBorder;
  final InputBorder errorBorder;
  final InputBorder focusedErrorBorder;
  final int maxLines;
  final TextInputType keyboardType;

  const BookingInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.isTextRequired = true,
    this.isFormFieldRequired = true,
    this.keyboardType = TextInputType.text,
    this.border = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.subHeadingColor),
    ),
    this.focusBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.subHeadingColor),
    ),
    this.errorBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.errorColor),
    ),
    this.focusedErrorBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.errorColor),
    ),
    this.maxLines = 1,
  });

  @override
  State<BookingInputField> createState() => _BookingInputFieldState();
}

class _BookingInputFieldState extends State<BookingInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: const TextStyle(
              color: AppColorConstant.black,
              fontFamily: 'Questrial',
              height: 1.75,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: widget.labelText,
              ),
              if (widget.isTextRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: AppColorConstant.errorColor,
                  ),
                ),
            ],
          ),
        ),
        if (widget.isFormFieldRequired)
          TextFormInputField(
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            textAlign: TextAlign.start,
            controller: widget.controller,
            hintText: widget.hintText,
            hintColor: AppColorConstant.black.withOpacity(0.6),
            hintFontWeight: FontWeight.normal,
            border: widget.border,
            focusBorder: widget.focusBorder,
            errorBorder: widget.errorBorder,
            focusedErrorBorder: widget.focusedErrorBorder,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
      ],
    );
  }
}
