import 'package:flutter/material.dart';
import 'package:makeupstarstudio/theme/color.dart';

class BodyText extends StatelessWidget {
  final Color color;
  final String text;
  final TextAlign textAlign;

  const BodyText(
    {super.key, 
    this.color = AppColorConstant.black, 
    required this.text,
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
        fontFamily: 'Questrial',
        color: color,
        fontSize: 14.0,
      ),
    );
  }
}