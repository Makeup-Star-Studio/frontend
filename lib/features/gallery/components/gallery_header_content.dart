import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class GalleryHeaderSection extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/image.jpeg',
    'assets/images/contact.png',
    'assets/images/testimonial.jpg',
  ];

  GalleryHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize, context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // Large Screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
    return Container(
      height: screenSize.height * 0.6,
      decoration: const BoxDecoration(
        color: AppColorConstant.buttonColor,
      ),
      child: Center(
        child: Container(
          width: screenSize.width * 0.5,
          height: screenSize.height * 0.5,
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppColorConstant.secondaryColor, width: 2.5),
              color: AppColorConstant.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const BigText(
                  text: 'Look Book',
                  size: 30.0,
                  height: 1.0,
                ),
                const SubHeadingSlanted(
                  text: '2024',
                  color: AppColorConstant.black,
                  size: 80.0,
                  height: 0.1,
                ),
                const SizedBox(
                  height: 20,
                ),
                const BodyText(
                  text:
                      'Discover the look that\'s Right for you...\n TO MY CLIENTS WHO',
                  size: 20.0,
                ),
                const BodyText(
                  text:
                      'Reshare my work of their service. Ask me if I need food or drinks. Tip me when possible. Understand that I am human and make errors. Compliment my work and show excitement.\n Thank you so much ❤️... I am so grateful for you!!',
                ),
                const SizedBox(height: 15),
                ModifiedButton(
                  text: 'Get in Touch',
                  press: () {
                    Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Medium Screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildSmallScreen(screenSize,
        context); // Reuse the large screen layout for medium screens
  }

  // Small Screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: screenSize.width,
          color: AppColorConstant.buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const BigText(
                text: 'Look Book',
                // Adjust size for small screens
                size: 24.0,
                height: 1.0,
              ),
              const SubHeadingSlanted(
                text: '2024',
                color: AppColorConstant.black,
                size: 60.0,
                height: 0.1,
              ),
              const SizedBox(
                height: 20,
              ),
              const BodyText(
                text:
                    'Discover the look that\'s Right for you...\n\n TO MY CLIENTS WHO',
                smallSize: 18.0,
              ),
              const BodyText(
                text:
                    'Reshare my work of their service\n Ask me if I need food or drinks\n Tip me when possible\n Understand that I am human and make errors\n Compliment my work and show excitement.\n\n Thank you so much ❤️\n I am so grateful for you!!',
                smallSize: 16.0,
              ),
              const SizedBox(height: 20),
              ModifiedButton(
                text: 'Get in Touch',
                press: () {
                  Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
