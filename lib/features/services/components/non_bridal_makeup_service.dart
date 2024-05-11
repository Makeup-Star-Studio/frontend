import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class NonBridalMakeupServiceSection extends StatefulWidget {
  const NonBridalMakeupServiceSection({super.key});

  @override
  NonBridalMakeupServiceSectionState createState() =>
      NonBridalMakeupServiceSectionState();
}

class NonBridalMakeupServiceSectionState
    extends State<NonBridalMakeupServiceSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.15, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: 350,
              height: 600,
              decoration: BoxDecoration(
                color: AppColorConstant.white,
                border: Border.all(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigText(
                      text: 'Makeup Application',
                      height: 1.0,
                      size: 25.0,
                    ),
                    const SubHeadingSlanted(
                        text: "what's included", height: 1.0),
                    const SizedBox(height: 20.0),
                    const BodyText(
                        text:
                            "At Makeup Star Studio, we excel in delivering subtle yet stunning glamour. As your dedicated beauty team, we prioritize offering you a lavish, personalized, and relaxing glam experience. Elevate your look to celebrity status with our top-tier makeup artists."),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Questrial',
                          height: 1.75,
                          fontSize: 14.0,
                        ),
                        children: [
                          TextSpan(text: "- MAKEUP APPLICATION | \$125+\n"),
                          TextSpan(text: "- MAKEUP TRIAL | \$105+\n"),
                          TextSpan(text: "- MAKEUP & HAIR | \$230+\n"),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 20.0),
                    const BodyText(
                      text: "Travel Fee: according to location",
                      size: 16.0,
                      color: AppColorConstant.subHeadingColor,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 300,
                      child: ButtonCard(
                        text: 'BOOK APPOINTMENT',
                        press: () {
                          Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Image.asset(
              'assets/images/nonbridal.png',
              width: 350,
              height: 600,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
