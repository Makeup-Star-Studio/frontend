import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class AboutTeamSection extends StatelessWidget {
  const AboutTeamSection({super.key});

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
          horizontal: screenSize.width * 0.1, vertical: 20.0),
      child: Center(
        child: Column(
          children: [
            const BigText(text: "About the team"),
            // SizedBox(height: 20.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Questrial',
                  color: AppColorConstant.black,
                  height: 1.75,
                  fontSize: ResponsiveWidget.isSmallScreen(context)
                      ? 18.0
                      : ResponsiveWidget.isMediumScreen(context)
                          ? 16.0
                          : 16.0,
                ),
                children: const [
                  TextSpan(
                    text:
                        "About the vibrant group of talented and driven individuals that make up Makeup Star Studio; they are committed to reinventing beauty. Our team is dedicated to accuracy and creativity, working together to bring out your inherent beauty and create transformations that will last a lifetime. We have a team of skilled ",
                  ),
                  TextSpan(
                    text: "Makeup Artists, Hair Stylists, and Henna Artists ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "who are passionate about their craft and dedicated to providing exceptional service. \n \n From ",
                  ),
                  TextSpan(
                    text:
                        "Saree Drapper to Non Bridal Hair for Bride's Wedding to Bridesmaid Hair & Makeup, ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "every member of our team brings a unique flair to everything from editorial photos to bridal beauty, helping Makeup Star StudioStudio stay at the forefront of the beauty industry. Together, we are more than simply hair and makeup artists—we are artisans who create unique, tailored experiences that boost self-esteem and celebrate individuality. \n \n To learn more about the creative talent and teamwork that characterize our outstanding team at Makeup Star StudioStudio, ",
                  ),
                  TextSpan(
                    text: "please contact us.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildSmallScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const BigText(text: "About the team"),
            // SizedBox(height: 20.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Questrial',
                  color: AppColorConstant.black,
                  height: 1.75,
                  fontSize: ResponsiveWidget.isSmallScreen(context)
                      ? 18.0
                      : ResponsiveWidget.isMediumScreen(context)
                          ? 16.0
                          : 16.0,
                ),
                children: const [
                  TextSpan(
                    text:
                        "About the vibrant group of talented and driven individuals that make up Makeup Star Studio; they are committed to reinventing beauty. Our team is dedicated to accuracy and creativity, working together to bring out your inherent beauty and create transformations that will last a lifetime. We have a team of skilled ",
                  ),
                  TextSpan(
                    text: "Makeup Artists, Hair Stylists, and Henna Artists ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "who are passionate about their craft and dedicated to providing exceptional service. \n \n From ",
                  ),
                  TextSpan(
                    text:
                        "Saree Drapper to Non Bridal Hair for Bride's Wedding to Bridesmaid Hair & Makeup, ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        "every member of our team brings a unique flair to everything from editorial photos to bridal beauty, helping Makeup Star StudioStudio stay at the forefront of the beauty industry. Together, we are more than simply hair and makeup artists—we are artisans who create unique, tailored experiences that boost self-esteem and celebrate individuality. \n \n To learn more about the creative talent and teamwork that characterize our outstanding team at Makeup Star StudioStudio, ",
                  ),
                  TextSpan(
                    text: "please contact us.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
