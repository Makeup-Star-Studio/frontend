import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class BodyText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextAlign textAlign;
  final double letterSpacing;
  final FontWeight fontWeight;
  final double height;

  const BodyText({
    super.key,
    this.color = AppColorConstant.black,
    required this.text,
    this.letterSpacing = 0.0,
    this.fontWeight = FontWeight.normal,
    this.size = 14.0,
    this.height = 1.75,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final isTablet = screenSize.shortestSide >= 600;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(        
        fontFamily: 'Questrial',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        height: height
      ),
    );
  }
}
