import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';
import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
import 'package:provider/provider.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});
  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RandomImageProvider>(context, listen: false).fetchAllImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(context),
      mediumScreen: _buildMediumScreen(context),
      smallScreen: _buildSmallScreen(context),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<RandomImageProvider>(
      builder: (context, imageProvider, child) {
        if (imageProvider.isLoading) {
          return const CircularProgressIndicator();
        } else if (imageProvider.images.isEmpty) {
          return const Text('No Data');
        } else {
          // Ensure you are accessing a valid index
          const imageIndex = 6; // Index you want to access
          if (imageProvider.images.length > imageIndex) {
            final image = imageProvider.images;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(250.0),
                        topLeft: Radius.circular(250.0),
                      ),
                      child: image.isNotEmpty
                          ? Image.network(
                              image[0].url,
                              fit: BoxFit.cover,
                              height: 600,
                            )
                          : Image.asset(
                              'assets/images/image.webp',
                              fit: BoxFit.cover,
                              height: 600,
                            ),
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BigText(text: 'LUXURY ON-SITE BEAUTY SERVICES'),
                        const SizedBox(height: 8.0),
                        const SubHeading(
                          text: 'elevating beauty & confidence',
                        ),
                        const SizedBox(height: 8.0),
                        const BodyText(
                          size: 16.0,
                          text:
                              'Hello, Im Geet, a lead artist of Makeup Star Studio. Our mission is to connect the clients with our team of talented beauty professionals to provide luxury on site beauty services while elevating your beauty and confidence. We want to provide you the luxury of having your own beauty squad to take care of all your beauty needs from Bridal Makeup to Saree Drapping, in the most convenient way possible - In the comfort of your home or location of your choice.',
                        ),
                        const SizedBox(height: 20.0),
                        ModifiedButton(
                          press: () {
                            Navigator.pushNamed(
                                context, WebsiteRoute.aboutRoute);
                          },
                          text: 'Know More About Us..',
                          size: 12.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Not enough images available');
          }
        }
      },
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return _buildSmallScreen(
        context); // Just using large screen layout for medium
  }

  Widget _buildSmallScreen(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Consumer<RandomImageProvider>(
      builder: (context, imageProvider, child) {
        if (imageProvider.isLoading) {
          return const CircularProgressIndicator();
        } else if (imageProvider.images.isEmpty) {
          return const Text('No Data');
        } else {
          // Ensure you are accessing a valid index
          const imageIndex = 6; // Index you want to access
          if (imageProvider.images.length > imageIndex) {
            final image = imageProvider.images;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1, vertical: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BigText(
                    text: 'LUXURY ON-SITE BEAUTY SERVICES',
                    height: 1.0,
                  ),
                  const SizedBox(height: 8.0),
                  const SubHeading(
                    text: 'elevating beauty & confidence',
                    height: 1.0,
                  ),
                  const SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(250.0),
                      topLeft: Radius.circular(250.0),
                    ),
                    child: image.isNotEmpty
                        ? Image.network(
                            image[0].url,
                            fit: BoxFit.cover,
                            width: 500,
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 500
                                : 650,
                          )
                        : Image.asset(
                            'assets/images/image.webp',
                            fit: BoxFit.cover,
                            width: 500,
                            height: ResponsiveWidget.isSmallScreen(context)
                                ? 500
                                : 650,
                          ),
                  ),
                  const SizedBox(height: 20.0),
                  const BodyText(
                    // size: 16.0,
                    text:
                        'Hello, Im Geet, a lead artist of Makeup Star Studio. Our mission is to connect the clients with our team of talented beauty professionals to provide luxury on site beauty services while elevating your beauty and confidence. We want to provide you the luxury of having your own beauty squad to take care of all your beauty needs from Bridal Makeup to Saree Drapping, in the most convenient way possible - In the comfort of your home or location of your choice.',
                  ),
                  const SizedBox(height: 20.0),
                  ModifiedButton(
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
                    },
                    text: 'Know More About Us..',
                    // size: 12.0,
                  ),
                ],
              ),
            );
          } else {
            return const Text('Not enough images available');
          }
        }
      },
    );
  }
}
