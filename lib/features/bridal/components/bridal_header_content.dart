import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class BridalHeaderSection extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/image.jpeg',
    'assets/images/contact.png',
    'assets/images/testimonial.jpg',
  ];

  BridalHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 659,
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
            height: 659,
            decoration: const BoxDecoration(
              color: AppColorConstant.buttonColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const BigText(
                  text: 'bridal makeup & hair',
                  size: 30.0,
                  height: 1.0,
                ),
                const SubHeadingSlanted(
                  text: 'by Geet',
                  color: AppColorConstant.black,
                  size: 80.0,
                  height: 0.5,
                ),
                const SizedBox(
                  height: 40,
                ),
                const BodyText(
                  text:
                      'Geet has a decade of experience in the hair and makeup industry, including as a freelance artist.\n Geet is incredibly passionate about her craft, and in ensuring that each of Makeup Star Studio\'s brides look and feel their best with every look that she creates!',
                ),
                const SizedBox(height: 20),
                ModifiedButton(
                    text: 'Get in Touch',
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.contactRoute);
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 659,
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
}
