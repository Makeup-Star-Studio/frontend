import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class WhyChooseUsSection extends StatefulWidget {
  const WhyChooseUsSection({super.key});

  @override
  _WhyChooseUsSectionState createState() => _WhyChooseUsSectionState();
}

class _WhyChooseUsSectionState extends State<WhyChooseUsSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorConstant.bgColor,
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const BigText(
                  textAlign: TextAlign.start,
                  text: 'Why Choose Us?',
                  size: 50.0,
                  // height: 84 / 50,
                ),
                const ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        'With expertise in makeup, hair styling, henna art, and saree draping, we offer a comprehensive range of services to fulfill all your beauty needs.',
                    size: 16.0,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        'We prioritize punctuality and reliability, providing our services conveniently at your preferred location, be it for weddings, special events, or everyday glam.',
                    size: 16.0,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        'From flawless makeup to eye-catching henna designs, we pay meticulous attention to every detail, ensuring perfection in every aspect of our services.',
                    size: 16.0,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        "We tailor our services to meet each client's unique preferences and requirements, guaranteeing a personalized and satisfactory experience.",
                    size: 16.0,
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        "Our team comprises highly skilled professionals trained by renowned artists, ensuring top-notch services.",
                    size: 16.0,
                  ),
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
          const SizedBox(width: 20.0),
          ClipRect(
            child: Image.asset(
              'assets/images/image.jpeg',
              width: 600.0,
              height: 600.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}