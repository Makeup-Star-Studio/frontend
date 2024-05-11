import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';

class BridalTextSection extends StatelessWidget {
  const BridalTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColorConstant.white,
          border: Border.all(
            color: AppColorConstant.black,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, WebsiteRoute.bookRoute);
            },
            child: const BodyText(
              text: "BOOK YOUR APPOINTMENT TODAY",
              fontWeight: FontWeight.w600,
              size: 20.0,
              letterSpacing: 2.0,
            ),
          )
        ]));
  }
}
