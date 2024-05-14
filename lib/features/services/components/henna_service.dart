import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class HennaServiceSection extends StatefulWidget {
  const HennaServiceSection({super.key});

  @override
  HennaServiceSectionState createState() => HennaServiceSectionState();
}

class HennaServiceSectionState extends State<HennaServiceSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize, context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // large screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.15, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: 350,
              height: screenSize.height,
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
                      text: 'Make your hands beautiful',
                      height: 1.0,
                      size: 25.0,
                    ),
                    const SubHeadingSlanted(
                        text: "what's included", height: 1.0),
                    const SizedBox(height: 20.0),
                    const BodyText(
                        text:
                            "Our unique designs reflect the Diversity of the art of henna in cultures unique to different parts of the World. Sindhi, Arabic, Morrocan, Indian, Western, Contemporary, and designs to suit your preference and style."),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Questrial',
                          height: 1.75,
                          fontSize: 14.0,
                        ),
                        children: [
                          TextSpan(
                              text: "- BRIDAL HENNA / HANDS & LEGS | \$200+\n"),
                          TextSpan(text: "- ONE HAND / FRONT | \$40+\n"),
                          TextSpan(text: "- ONE HAND / FRONT & BACK | \$80+\n"),
                          TextSpan(text: "- BOTH HANDS / FRONT | \$80+\n"),
                          TextSpan(
                              text: "- BOTH HANDS / FRONT & BACK | \$160+\n"),
                          TextSpan(text: "- FEET | \$80+\n"),
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
            child: ClipRect(
              child: Image.asset(
                'assets/images/service3.jpg',
                width: 350,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/service3.jpg',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: AppColorConstant.white,
              border: Border(
                left: BorderSide(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
                right: BorderSide(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BigText(
                    text: 'Make your hands beautiful',
                    height: 1.0,
                    mediumSize: 30.0,
                  ),
                  const SubHeadingSlanted(text: "what's included", height: 1.0),
                  const SizedBox(height: 20.0),
                  const BodyText(
                      text:
                          "Our unique designs reflect the Diversity of the art of henna in cultures unique to different parts of the World. Sindhi, Arabic, Morrocan, Indian, Western, Contemporary, and designs to suit your preference and style."),
                  const SizedBox(height: 20.0),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        height: 1.75,
                        fontSize: 14.0,
                      ),
                      children: [
                        TextSpan(
                            text: "- BRIDAL HENNA / HANDS & LEGS | \$200+\n"),
                        TextSpan(text: "- ONE HAND / FRONT | \$40+\n"),
                        TextSpan(text: "- ONE HAND / FRONT & BACK | \$80+\n"),
                        TextSpan(text: "- BOTH HANDS / FRONT | \$80+\n"),
                        TextSpan(
                            text: "- BOTH HANDS / FRONT & BACK | \$160+\n"),
                        TextSpan(text: "- FEET | \$80+\n"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const BodyText(
                    text: "Travel Fee: according to location",
                    smallSize: 16.0,
                    color: AppColorConstant.subHeadingColor,
                  ),
                  const SizedBox(height: 10.0),
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
        ],
      ),
    );
  }
}
