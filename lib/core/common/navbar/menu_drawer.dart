import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColorConstant.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: const Color(0xffF0E7E3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                      },
                      child: const BodyText(
                        text: 'BOOK APPOINTMENT',
                        // letterSpacing: 2.0,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_alt_sharp,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, WebsiteRoute.homeRoute);
                },
                child: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
                },
                child: const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, WebsiteRoute.servicesRoute);
                },
                child: const Text(
                  'Services',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, WebsiteRoute.bridalRoute);
                },
                child: const Text(
                  'Bridal',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, WebsiteRoute.galleryRoute);
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, WebsiteRoute.contactRoute);
              //   },
              //   child: const Text(
              //     'Contact',
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 18,
              //     ),
              //   ),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 | Makeup Star Studio',
                    style: TextStyle(
                      color: Colors.brown[400],
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
