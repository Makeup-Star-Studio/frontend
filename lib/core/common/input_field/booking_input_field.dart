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
  final int maxLines;

  const BookingInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.isTextRequired = true,
    this.isFormFieldRequired = true,
    this.border = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.subHeadingColor),
    ),
    this.focusBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColorConstant.subHeadingColor),
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
              fontFamily: 'Questrial',
              height: 1.75,
              fontSize: 16.0,
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
            maxLines: widget.maxLines,
            textAlign: TextAlign.start,
            controller: widget.controller,
            hintText: widget.hintText,
            border: widget.border,
            focusBorder: widget.focusBorder,
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
