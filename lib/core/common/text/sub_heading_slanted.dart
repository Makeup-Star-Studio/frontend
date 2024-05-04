import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class SubHeadingSlanted extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextAlign textAlign;

  const SubHeadingSlanted(
    {super.key, 
    this.color = AppColorConstant.subHeadingColor, 
    required this.text, 
    this.size = 50.0,
    this.textAlign = TextAlign.center,
    }
  );

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final isTablet = screenSize.shortestSide >= 600;
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Sebastian Bobby',
        color: color,
        fontSize: size,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}