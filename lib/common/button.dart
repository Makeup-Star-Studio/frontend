import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/text/body.dart';
import 'package:makeupstarstudio/theme/color.dart';

class ModifiedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  final Color color, textColor;
  const ModifiedButton({
    super.key,
    required this.text,
    required this.press,
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
      child: BodyText(
        text: text,
        color: textColor,
      ),
    );
  }
}
