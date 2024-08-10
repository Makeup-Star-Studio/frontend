import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class SubHeadingSlanted extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double mediumSize;
  final double smallSize;
  final TextAlign textAlign;
  final double height;

  const SubHeadingSlanted({
    super.key,
    this.color = AppColorConstant.subHeadingColor,
    required this.text,
    this.size = 70.0,
    this.mediumSize = 70.0,
    this.smallSize = 65.0,
    this.textAlign = TextAlign.center,
    this.height = 1.5,
  });

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
        fontSize: ResponsiveWidget.isSmallScreen(context)
            ? smallSize
            : ResponsiveWidget.isMediumScreen(context)
                ? mediumSize
                : size,
        fontStyle: FontStyle.italic,
        height: height,
      ),
    );
  }
}
