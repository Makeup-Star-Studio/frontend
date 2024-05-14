import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class ServiceHeaderSection extends StatelessWidget {
  const ServiceHeaderSection({super.key});

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
    return Container(
      height: screenSize.height,
      padding: screenSize.width > 900
          ? const EdgeInsets.symmetric(horizontal: 50.0, vertical: 90.0)
          : const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/service_header.jpg'),
          fit: BoxFit.cover,
          opacity: 0.75,
        ),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                    fontFamily: 'Cradley',
                    height: 1.25,
                    fontSize: 45.0,
                    letterSpacing: 2.0),
                children: [
                  TextSpan(text: "luxurious &\n"),
                  TextSpan(text: "elevated"),
                ],
              ),
            ),
            const SubHeadingSlanted(
              text: 'beauty services',
              height: 1,
              size: 80,
              color: AppColorConstant.black,
            ),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 16.0,
                ),
                children: [
                  TextSpan(text: "WE'RE YOUR GO-T0 GIRLS TO HELP YOU\n"),
                  TextSpan(text: "FEEL & LOOK YOUR BEST INSIDE & OUT!"),
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
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // smll screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/service_header.jpg',
              fit: BoxFit.cover,
              width: screenSize.width,
              height: screenSize.height * 0.5,
            ),
          ),
          const SizedBox(height: 20.0),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Cradley',
                  height: 1.25,
                  fontSize: 40.0,
                  letterSpacing: 2.0),
              children: [
                TextSpan(text: "luxurious &\n"),
                TextSpan(text: "elevated"),
              ],
            ),
          ),
          const SubHeadingSlanted(
            text: 'beauty services',
            height: 1,
            // size: 70,
            // smallSize: 50,
            // color: AppColorConstant.black,
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: AppColorConstant.black,
                fontFamily: 'Questrial',
                height: 1.75,
                fontSize: 18.0,
              ),
              children: [
                TextSpan(text: "WE'RE YOUR GO-T0 GIRLS TO HELP YOU\n"),
                TextSpan(text: "FEEL & LOOK YOUR BEST INSIDE & OUT!"),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
