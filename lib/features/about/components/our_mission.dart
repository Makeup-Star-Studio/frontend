import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';

class AboutMissionSection extends StatelessWidget {
  const AboutMissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.15, vertical: 50.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Making the box shape circular
              color: Colors.grey[200],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            width: 450,
            height: 550,
            child: ClipRect(
              child: Image.asset(
                'assets/images/testimonial.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 50.0,
          ),
          Expanded(
            child: Column(
              children: [
                const BigText(
                  text: 'OUR MISSION',
                  size: 50.0,
                  // height: 84/50,
                  color: AppColorConstant.secondaryColor,
                ),
                const SubHeading(
                  text: 'serving Bay Area & beyond',
                  // height: 84/50,
                  color: AppColorConstant.black,
                ),
                const BodyText(
                  text:
                      "Our goal is to empower individuals by enhancing their natural beauty through our expertise in makeup artistry, hair styling, henna art, and saree draping. We strive to create a memorable and transformative experience for each client, leaving them feeling confident, beautiful, and radiant on every occasion. With our collaborative efforts, we aim to make every client look and feel their absolute best, celebrating their unique beauty and style.",
                  size: 16.0,
                ),
                const SizedBox(height: 10.0),
                const BodyText(
                  text:
                      "We wanted to offer something that was convenient for the girl on the go, while giving you the luxury of having your own personal glam team. The best part? All of our services are delivered to you, exclusively on site only.",
                  size: 16.0,
                ),
                const SizedBox(height: 20.0),
                ModifiedButton(
                  press: () {},
                  text: 'VIEW OUR SERVICES',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
