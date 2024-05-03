import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/text/body.dart';
import 'package:makeupstarstudio/common/text/heading.dart';
import 'package:makeupstarstudio/theme/color.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const BigText(
                    text: 'Our Main Mission',
                    size: 50.0,
                    color: AppColorConstant.secondaryColor,
                  ),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onTap: () {},
                    child: const BodyText(
                      text: 'TAKING MODERN BEAUTY TO THE NEXT LEVEL.',
                      size: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const BodyText(
                    text:
                        'We wanted to create a unique luxurious, yet relaxed experience for the everyday woman. We understand that life can get crazy, and we do not always have time to get a blowout, keep up with our glow, and keep up with our beauty regimen, while running from appointment to appointment. We wanted to offer something to not only make you feel beautiful inside and out, but to save you time and the energy of doing it all yourself! Mane Chic is delivering beauty services to you, while elevating your confidence!',
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
