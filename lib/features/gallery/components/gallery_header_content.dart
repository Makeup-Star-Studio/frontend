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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            height: screenSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(imageUrls[0]), fit: BoxFit.cover),
            ),
          ),
        ),
        //text
        Expanded(
          child: Container(
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: AppColorConstant.buttonColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 40,
                ),
                const BodyText(
                  text:
                      'Discover the look that\'s Right for you...\n\n TO MY CLIENTS WHO',
                  size: 20.0,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                const BodyText(
                    text:
                        'Reshare my work of their service\n Ask me if I need food or drinks\n Tip me when possible\n Understand that I am human and make errors\n Compliment my work and show excitement.\n\n Thank you so much ❤️\n I am so grateful for you!!'),
                const SizedBox(height: 20),
                ModifiedButton(
                    text: 'Get in Touch',
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: screenSize.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(imageUrls[1]), fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: screenSize.height * 0.75,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(imageUrls[1]), fit: BoxFit.cover),
          ),
        ),
        //text
        Container(
          // height: screenSize.height * 0.7,
          width: screenSize.width,
          decoration: const BoxDecoration(
            color: AppColorConstant.buttonColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const BigText(
                  text: 'Look Book',
                  // size: 30.0,
                  height: 1.0,
                ),
                const SubHeadingSlanted(
                  text: '2024',
                  color: AppColorConstant.black,
                  // size: 80.0,
                  height: 0.1,
                ),
                const SizedBox(
                  height: 40,
                ),
                const BodyText(
                  text:
                      'Discover the look that\'s Right for you...\n\n TO MY CLIENTS WHO',
                  smallSize: 20.0,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                const BodyText(
                    text:
                        'Reshare my work of their service\n Ask me if I need food or drinks\n Tip me when possible\n Understand that I am human and make errors\n Compliment my work and show excitement.\n\n Thank you so much ❤️\n I am so grateful for you!!'),
                const SizedBox(height: 20),
                ModifiedButton(
                    text: 'Get in Touch',
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
