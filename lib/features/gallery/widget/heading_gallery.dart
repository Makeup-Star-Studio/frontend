import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class HeadingGalleryOptions extends StatefulWidget {
  final String text;
  const HeadingGalleryOptions({required this.text, super.key});

  @override
  State<HeadingGalleryOptions> createState() => _HeadingGalleryOptionsState();
}

class _HeadingGalleryOptionsState extends State<HeadingGalleryOptions> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          SubHeadingSlanted(
            text: widget.text,
            color: AppColorConstant.black,
            size: 80.0,
            mediumSize: 70.0,
            smallSize: 45.0,
            // fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            width: 10,
          ),
          if (!ResponsiveWidget.isSmallScreen(context))
            Expanded(
              child: Container(
                // create a line
                height: 2.0,
                width: ResponsiveWidget.isSmallScreen(context)
                    ? screenSize.width * 0.2
                    : screenSize.width * 0.65,
                color: AppColorConstant.secondaryColor,
              ),
            )
        ],
      ),
    );
  }
}
