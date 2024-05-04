import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class WorkingCard extends StatelessWidget {
  final String title;
  final String desc;
  const WorkingCard(
    {super.key,
    required this.title,
    required this.desc,
    } 
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColorConstant.backgroundColor,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BigText(
              text: title,
              size: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BodyText(
              text: desc,
            ),
          ),
        ],
      ),
    );
  }
}