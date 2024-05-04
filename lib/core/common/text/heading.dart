import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class BigText extends StatelessWidget {
  final Color color;
  final String text;
  final double size; 
  final TextAlign textAlign;
  final FontWeight fontWeight;
  // final double height;
  // final TextOverflow overflow;

  const BigText(
    {super.key, 
    this.color = AppColorConstant.black, 
    required this.text, 
    this.fontWeight = FontWeight.normal,
    this.size = 40.0,
    // this.height = 84 / 40,
    // this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.center,
    }
  );

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    // final isTablet = screenSize.shortestSide >= 600;
    return Text(
      text,
      // maxLines: 2,
      // overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Cradley',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        // height: height,
      ),
    );
  }
}