import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class HennaServiceSection extends StatefulWidget {
  const HennaServiceSection({super.key});

  @override
  HennaServiceSectionState createState() =>
      HennaServiceSectionState();
}

class HennaServiceSectionState
    extends State<HennaServiceSection> {
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
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BigText(
                      text: 'Make your hands beautiful',
                      height: 1.0,
                      size: 25.0,
                    ),
                    const SubHeadingSlanted(
                        text: "what's included", height: 1.0),
                    const SizedBox(height: 20.0),
                    const BodyText(
                        text:
                            "Our unique designs reflect the Diversity of the art of henna in cultures unique to different parts of the World. Sindhi, Arabic, Morrocan, Indian, Western, Contemporary, and designs to suit your preference and style."),
                    const SizedBox(height: 20.0),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: 'Questrial',
                          height: 1.75,
                          fontSize: 14.0,
                        ),
                        children: [
                          TextSpan(text: "- BRIDAL HENNA / HANDS & LEGS | \$200+\n"),
                          TextSpan(text: "- ONE HAND / FRONT | \$40+\n"),
                          TextSpan(text: "- ONE HAND / FRONT & BACK | \$80+\n"),
                          TextSpan(text: "- BOTH HANDS / FRONT | \$80+\n"),
                          TextSpan(text: "- BOTH HANDS / FRONT & BACK | \$160+\n"),
                          TextSpan(text: "- FEET | \$80+\n"),
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
                    SizedBox(
                      width: 300,
                      child: ButtonCard(
                      text: 'BOOK APPOINTMENT',
                      press: () {},
                    ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Image.asset(
              'assets/images/service3.jpg',
              width: 350,
              height: 600,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
