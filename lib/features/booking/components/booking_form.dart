import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/features/booking/widget/booking_form_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingFormSection extends StatefulWidget {
  const BookingFormSection({super.key});

  @override
  State<BookingFormSection> createState() => _BookingFormSectionState();
}

class _BookingFormSectionState extends State<BookingFormSection> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context)
              ? 20
              : screenSize.width * 0.15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyText(
            text: 'For bookings & inquiries, contact:',
            fontWeight: FontWeight.w600,
            smallSize: 20.0,
            mediumSize: 20.0,
            size: 22.0,
          ),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              _launchEmail('info@makeupstarstudio.com');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: 'Email: ',
                  ),
                  TextSpan(
                    text: 'info@makeupstarstudio.com',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColorConstant.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              _launchURL('https://maps.app.goo.gl/Yj5N8eYKiPm6udRm7');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: 'Location: ',
                  ),
                  TextSpan(
                    text: '60 Descanso Dr, San Jose, CA 95134, United States',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColorConstant.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          /*-----------------------------------------------*/
          if (ResponsiveWidget.isSmallScreen(context))
            // const SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovering = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovering = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    launchWhatsApp();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: ResponsiveWidget.isSmallScreen(context) ? 80 : 180,
                    height: ResponsiveWidget.isSmallScreen(context) ? 50 : 65,
                    decoration: const BoxDecoration(
                      color: AppColorConstant.successColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        bottomLeft: Radius.circular(100.0),
                      ),
                    ),
                    transform: _isHovering
                        ? Matrix4.diagonal3Values(1.1, 1.1, 1)
                        : Matrix4.diagonal3Values(1, 1, 1),
                    child: Image.asset(
                      'assets/icons/whatsapp.png', // Change to the actual path of WhatsApp logo
                      fit: BoxFit.contain,
                      width: ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
                      height: ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
                    ),
                  ),
                ),
              ),
            ),
/*-----------------------------------------------*/
          const BookingFormWidget(),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String url = emailLaunchUri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  Future<void> launchWhatsApp() async {
    const url = 'https://wa.link/yoty74'; // Replace with your WhatsApp number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
