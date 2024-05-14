import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class HeaderContentServiceSection extends StatelessWidget {
  final String title;
  final String subTitle;

  const HeaderContentServiceSection({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigText(
              text: title,
              height: 1.0,
              letterSpacing: 3.0,
            ),
            SubHeadingSlanted(
              height: 1.0,
              size: 70.0,
              text: subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
