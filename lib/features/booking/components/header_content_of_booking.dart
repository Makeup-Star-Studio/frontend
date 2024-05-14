import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class HeaderContentBookingSection extends StatelessWidget {
  final String title;
  final String subTitle;

  const HeaderContentBookingSection({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ResponsiveWidget.isSmallScreen(context)
          ? AppColorConstant.bgColor
          : AppColorConstant.backgroundColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
            ResponsiveWidget.isSmallScreen(context) ? 16.0 : 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(
              text: title,
              height: 1.0,
              size: 30.0,
              letterSpacing: 3.0,
            ),
            SubHeadingSlanted(
              height: 1.0,
              size: 60.0,
              text: subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
