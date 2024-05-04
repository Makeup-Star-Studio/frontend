import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.1, 
        vertical: 50.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 600,
            child: Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(250.0),
                  topLeft: Radius.circular(250.0),
                ),
                child: Image.asset(
                  'assets/images/image.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BigText(text: 'LUXURY ON-SITE BEAUTY SERVICES'),
                const SizedBox(height: 8.0),
                const SubHeading(
                  text: 'elevating beauty & confidence',
                ),
                const SizedBox(height: 8.0),
                const BodyText(
                  size: 16.0,
                  text:
                      'Hello, Im Geet, a lead artist of Makeup Star Studio. Our mission is to connect the clients with our team of talented beauty professionals to provide luxury on site beauty services while elevating your beauty and confidence. We want to provide you the luxury of having your own beauty squad to take care of all your beauty needs from Bridal Makeup to Saree Drapping, in the most convenient way possible - In the comfort of your home or location of your choice.',
                ),
                const SizedBox(height: 20.0),
                ModifiedButton(
                  press: () {},
                  text: 'Know More About Us..',
                  size: 12.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
