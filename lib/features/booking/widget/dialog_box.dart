import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDialogBox extends StatelessWidget {
  const BookingDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0),
          ),
        ),
        // Dialog box
        AlertDialog(
          title: const SubHeadingSlanted(
            text: 'Booking Submitted',
            height: 1.75,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BodyText(
                  text:
                      'Your booking has reached us, thank you for choosing Makeup Star Studio. We\'ll shortly contact you via email or call.'),
              const SizedBox(height: 20),
              const BodyText(
                  text: 'If it\'s urgent, please contact us on WhatsApp.'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => launchWhatsApp(),
                    child: Image.asset(
                      'assets/icons/whatsapp.png', // Change to the actual path of WhatsApp logo
                      fit: BoxFit.contain,
                      width: 30,
                      height: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      launchWhatsApp();
                    },
                    child: const BodyText(
                      text: 'Contact us on WhatsApp',
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const BodyText(
                text: 'OK',
                color: AppColorConstant.adminMenuColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> launchWhatsApp() async {
    const url = 'https://wa.me/14156960258';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
