import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
class BookingHeaderSection extends StatefulWidget {
  const BookingHeaderSection({super.key});

  @override
  State<BookingHeaderSection> createState() => _BookingHeaderSectionState();
}

class _BookingHeaderSectionState extends State<BookingHeaderSection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height,
      color: AppColorConstant.backgroundColor,
      // padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BigText(
                    text: 'in need of a beauty team asap?',
                    color: AppColorConstant.secondaryColor,
                    height: 1.0,
                    // height: 84 / 50,
                  ),
                  const SizedBox(height: 40.0),
                  const BodyText(
                    text:
                        "WE'RE YOUR GO-TO GIRLS TO HELP YOU FEEL & LOOK YOUR MOST BEAUTIFUL.",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20.0),
                  const BodyText(
                    text:
                        "Thank you so much for your consideration in working with the Makeup Star Studio Beauty Team! In need of a beauty team? Use the link below to instantly book one of our professional beauty stylists! For all Bridal & Event Inquiries, please use this booking form below to get in touch with us, and we'll get back to you shortly! ",
                    size: 16.0,
                  ),
                  const SizedBox(height: 20.0),
                  ButtonCard(
                    press: () {},
                    text: 'BOOK AN APPOINTMENT',
                  ),
                  const SizedBox(height: 20.0),
                  ButtonCard(
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.contactRoute);
                    },
                    text: 'CONTACT US',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: ClipRect(
              child: Image.asset(
                'assets/images/image.jpeg',
                // width: 500.0,
                // height: 500.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}