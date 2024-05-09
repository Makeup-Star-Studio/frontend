import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/button_card.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class SareeDrappingServiceSection extends StatefulWidget {
  const SareeDrappingServiceSection({super.key});

  @override
  SareeDrappingServiceSectionState createState() =>
      SareeDrappingServiceSectionState();
}

class SareeDrappingServiceSectionState
    extends State<SareeDrappingServiceSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.15, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/service4.jpg',
              width: 350,
              height: 600,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Container(
              width: 350,
              height: 600,
              decoration: BoxDecoration(
                color: AppColorConstant.white,
                border: Border.all(
                  color: AppColorConstant.secondaryColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigText(
                      text: 'Elegance in every fold',
                      height: 1.0,
                      size: 25.0,
                    ),
                    const SubHeadingSlanted(text: "what's included", height: 1.0),
                    const SizedBox(height: 20.0),
                    const BodyText(
                        text:
                            "Experience the artistry of flawless saree draping at Makeup Star Studio. Our expert drapers ensure a seamless, picture-perfect look that enhances your elegance and confidence effortlessly."),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Questrial',
                          height: 1.75,
                          fontSize: 14.0,
                        ),
                        children: [
                          TextSpan(text: "- BRIDAL SAREE DRAPPING | \$80+\n"),
                          TextSpan(text: "- GUEST SAREE DRAPPING | \$50+\n"),
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
                    const SizedBox(
                      width: 300,
                      child: ButtonCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
