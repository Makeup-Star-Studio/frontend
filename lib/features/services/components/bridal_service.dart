import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class BridalServiceSection extends StatefulWidget {
  const BridalServiceSection({super.key});

  @override
  BridalServiceSectionState createState() => BridalServiceSectionState();
}

class BridalServiceSectionState extends State<BridalServiceSection> {
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
            child: ClipRect(
              child: Image.asset(
                'assets/images/service1.jpg',
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BigText(
                    text: 'All about the bride',
                    height: 1.0,
                    size: 25.0,
                  ),
                  const SubHeadingSlanted(text: "what's included", height: 1.0),
                  const SizedBox(height: 20.0),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        height: 1.75,
                        fontSize: 14.0,
                      ),
                      children: [
                        TextSpan(text: "- BRIDAL MAKEUP | \$195+\n"),
                        TextSpan(text: "- BIRDAL HAIR | \$175+\n"),
                        TextSpan(text: "- BRIDAL MAKEUP & HAIR | \$350+\n"),
                        TextSpan(text: "- BRIDAL MAKEUP TRIAL | \$125+\n"),
                        TextSpan(text: "- BRIDAL HAIR TRIAL | \$100+\n"),
                        TextSpan(
                            text: "- BRIDAL MAKEUP & HAIR TRIAL | \$235+\n"),
                        TextSpan(
                          text: "Additional\n",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "- BRIDAL HENNA | \$100+\n"),
                        TextSpan(text: "- BRIDAL SAREE DRAPPING | \$85+\n"),
                        TextSpan(text: "- BRIDAL HAIR EXTENSIONS | \$200+\n"),
                        TextSpan(text: "- BM / GUEST MAKEUP | \$135+\n"),
                        TextSpan(text: "- BM / GUEST HAIR | \$115+\n"),
                        TextSpan(text: "- BM / GUEST HENNA | \$50+\n"),
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
          horizontal: screenSize.width * 0.15, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/service1.jpg',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          // const SizedBox(width: 20.0),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BigText(
                  text: 'All about the bride',
                  height: 1.0,
                  // size: 25.0,
                  mediumSize: 30.0,
                ),
                const SubHeadingSlanted(text: "what's included", height: 1.0),
                const SizedBox(height: 20.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      height: 1.75,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: "- BRIDAL MAKEUP | \$195+\n"),
                      TextSpan(text: "- BIRDAL HAIR | \$175+\n"),
                      TextSpan(text: "- BRIDAL MAKEUP & HAIR | \$350+\n"),
                      TextSpan(text: "- BRIDAL MAKEUP TRIAL | \$125+\n"),
                      TextSpan(text: "- BRIDAL HAIR TRIAL | \$100+\n"),
                      TextSpan(text: "- BRIDAL MAKEUP & HAIR TRIAL | \$235+\n"),
                      TextSpan(
                        text: "Additional\n",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: "- BRIDAL HENNA | \$100+\n"),
                      TextSpan(text: "- BRIDAL SAREE DRAPPING | \$85+\n"),
                      TextSpan(text: "- BRIDAL HAIR EXTENSIONS | \$200+\n"),
                      TextSpan(text: "- BM / GUEST MAKEUP | \$135+\n"),
                      TextSpan(text: "- BM / GUEST HAIR | \$115+\n"),
                      TextSpan(text: "- BM / GUEST HENNA | \$50+\n"),
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
        ],
      ),
    );
  }
}
