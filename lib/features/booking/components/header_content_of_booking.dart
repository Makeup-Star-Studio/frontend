import 'package:flutter/material.dart';
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
    return SizedBox(
      width: double.infinity,
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
    );
  }
}
