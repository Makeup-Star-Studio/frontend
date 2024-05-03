import 'package:flutter/material.dart';
import 'package:makeupstarstudio/theme/color.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final TextAlign textAlign;

  const BigText(
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
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Cradley',
        color: color,
        fontSize: 40.0,
      ),
    );
  }
}