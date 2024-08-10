import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class BodyText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double mediumSize;
  final double smallSize;
  final TextAlign textAlign;
  final double letterSpacing;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double height;

  const BodyText({
    super.key,
    this.color = AppColorConstant.black,
    required this.text,
    this.letterSpacing = 0.0,
    this.fontWeight = FontWeight.normal,
    this.size = 16.0,
    this.mediumSize = 16.0,
    this.smallSize = 14.0,
    this.fontStyle = FontStyle.normal,
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
          fontStyle: fontStyle,
          fontSize: ResponsiveWidget.isSmallScreen(context)
              ? smallSize
              : ResponsiveWidget.isMediumScreen(context)
                  ? mediumSize
                  : size,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          height: height),
    );
  }
}
