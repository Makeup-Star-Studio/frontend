import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class LittleAboutMeSection extends StatefulWidget {
  const LittleAboutMeSection({super.key});

  @override
  _LittleAboutMeSectionState createState() => _LittleAboutMeSectionState();
}

class _LittleAboutMeSectionState extends State<LittleAboutMeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColorConstant.bgColor,
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BigText(
                  textAlign: TextAlign.start,
                  text: 'Little More About Geet',
                  // height: 84 / 50,
                ),
                ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        "Apart from being a certified makeup artist, hair stylist & heena artist, Geet is also a technical recruiter.",
                    size: 16.0,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        "When she is not serving clients, Geet can be found exercising and walking around Santa Cruz beach.",
                    size: 16.0,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text:
                        "She enjoys a good read in her local library and also loves to binge watch Netflix series.",
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
          ClipRect(
            child: Image.asset(
              'assets/images/profile.jpg',
              width: 700.0,
              height: 500.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
