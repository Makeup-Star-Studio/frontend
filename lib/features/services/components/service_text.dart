import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class ServiceTextSection extends StatelessWidget {
  const ServiceTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: AppColorConstant.black,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText(
                text: "let's get you glam, beautiful",
                fontWeight: FontWeight.w600,
                size: 28.0,
                color: AppColorConstant.white,
              )
            ]));
  }
}
