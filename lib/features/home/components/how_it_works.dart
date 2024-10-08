import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/features/home/components/working_card.dart';

class WorkingSection extends StatelessWidget {
  const WorkingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveWidget.isSmallScreen(context)
            ? 20
            : screenSize.width * 0.1,
        // top: 20.0,
        // bottom: 20.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubHeadingSlanted(
            text: 'How it Works',
            size: 80.0,
            height: 1.0,
          ),
          const SizedBox(height: 10.0),
          if (ResponsiveWidget.isSmallScreen(context)) ...[
            const Column(
              children: [
                WorkingCard(
                  title: 'SERVICES',
                  desc:
                      'Select your beauty service, from Bridal Makeup to Saree Drapping we have you covered! We offer weekly beauty maintenance, weddings & events!',
                ),
                SizedBox(height: 20.0),
                WorkingCard(
                  title: 'LOCATION',
                  desc:
                      'Choose the location of your choice, whether its a venue, or from the comfort of your home. We are here to save you time- all of our services are exclusively on site. ',
                ),
                SizedBox(height: 20.0),
                WorkingCard(
                  title: 'BEAUTY MASTERS',
                  desc:
                      'Time to get glam and have your own personal beauty team! We will match you with one of our elite beauty  artists, who have a love and obsession for what they do! ',
                ),
              ],
            )
          ] else ...[
            const Row(
              children: [
                Expanded(
                  child: WorkingCard(
                    title: 'SERVICES',
                    desc:
                        'Select your beauty service, from Bridal Makeup to Saree Drapping we have you covered! We offer weekly beauty maintenance, weddings & events!',
                  ),
                ),
                Expanded(
                  child: WorkingCard(
                    title: 'LOCATION',
                    desc:
                        'Choose the location of your choice, whether its a venue, or from the comfort of your home. We are here to save you time- all of our services are exclusively on site. ',
                  ),
                ),
                Expanded(
                  child: WorkingCard(
                    title: 'BEAUTY MASTERS',
                    desc:
                        'Time to get glam and have your own personal beauty team! We will match you with one of our elite beauty  artists, who have a love and obsession for what they do! ',
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20.0),
          ModifiedButton(
              text: 'BOOK YOUR APPOINTMENT',
              size: 12.0,
              letterSpacing:
                  ResponsiveWidget.isSmallScreen(context) ? 1.0 : 2.0,
              press: () {
                Navigator.pushNamed(context, WebsiteRoute.bookRoute);
              }),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
