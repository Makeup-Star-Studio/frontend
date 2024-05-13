import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(context),
      mediumScreen: _buildMediumScreen(context),
      smallScreen: _buildSmallScreen(context),
    );
  }

  // large screen
  Widget _buildLargeScreen(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/mission_bg.jpeg',
            ),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          color: AppColorConstant.backgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  BigText(
                    text: 'Our Main Mission',
                    size: ResponsiveWidget.isLargeScreen(context) ? 50.0 : 40.0,
                    height: ResponsiveWidget.isLargeScreen(context) ? 1.5 : 1.0,
                    color: AppColorConstant.secondaryColor,
                  ),
                  InkWell(
                    mouseCursor: MaterialStateMouseCursor.clickable,
                    hoverColor: Colors.transparent,
                    onTap: () {},
                    child: const BodyText(
                      text: '"TAKING MODERN BEAUTY TO THE NEXT LEVEL."',
                      // size: ,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const BodyText(
                    text:
                        'We wanted to create a unique luxurious, yet relaxed experience for the everyday woman. We understand that life can get crazy, and we do not always have time to get a blowout, keep up with our glow, and keep up with our beauty regimen, while running from appointment to appointment. We wanted to offer something to not only make you feel beautiful inside and out, but to save you time and the energy of doing it all yourself! Makeup Star studio is delivering beauty services to you, while elevating your confidence!',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // medium screen
  Widget _buildMediumScreen(BuildContext context) {
    return _buildLargeScreen(
        context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const BigText(
            text: 'Our Main Mission',
            // size: 50.0,
            color: AppColorConstant.secondaryColor,
          ),
          InkWell(
            mouseCursor: MaterialStateMouseCursor.clickable,
            hoverColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
            },
            child: const BodyText(
              text: '"TAKING MODERN BEAUTY TO THE NEXT LEVEL."',
              size: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: BodyText(
              text:
                  'We wanted to create a unique luxurious, yet relaxed experience for the everyday woman. We understand that life can get crazy, and we do not always have time to get a blowout, keep up with our glow, and keep up with our beauty regimen, while running from appointment to appointment. We wanted to offer something to not only make you feel beautiful inside and out, but to save you time and the energy of doing it all yourself! Makeup Star studio is delivering beauty services to you, while elevating your confidence!',
              size: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
