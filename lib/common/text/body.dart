import 'package:flutter/material.dart';
import 'package:makeupstarstudio/theme/color.dart';

class BodyText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextAlign textAlign;

  const BodyText({
    super.key,
    this.color = AppColorConstant.black,
    required this.text,
    this.size = 14.0,
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
        height: 1.75
      ),
    );
  }
}
