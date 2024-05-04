import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class ModifiedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  final double size;
  final double letterSpacing;
  final FontWeight fontWeight;

  const ModifiedButton({
    super.key,
    required this.text,
    required this.press,
    this.size = 14.0,
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 1.0,
    this.color = AppColorConstant.buttonColor,
    this.textColor = AppColorConstant.black,
  });

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final isTablet = screenSize.shortestSide >= 600;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        // border none
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 35.0,
          vertical: 20.0,
        ),
      ),
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: size,
          letterSpacing: letterSpacing,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
