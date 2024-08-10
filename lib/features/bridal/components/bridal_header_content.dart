import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
import 'package:provider/provider.dart';

class BridalHeaderSection extends StatefulWidget {
  const BridalHeaderSection({super.key});
  @override
  State<BridalHeaderSection> createState() => _BridalHeaderSectionState();
}

class _BridalHeaderSectionState extends State<BridalHeaderSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RandomImageProvider>(context, listen: false).fetchAllImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize, context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // Large Screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // First expanded section
                Expanded(
                  child: Container(
                    height: 659,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: image.isNotEmpty
                              ? NetworkImage(image[5].url) as ImageProvider
                              : const AssetImage('assets/images/image.webp')
                                  as ImageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                // Text section
                Expanded(
                  child: Container(
                    height: 659,
                    decoration: const BoxDecoration(
                      color: AppColorConstant.buttonColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const BigText(
                          text: 'bridal makeup & hair',
                          size: 30.0,
                          height: 1.0,
                        ),
                        const SubHeadingSlanted(
                          text: 'by Geet',
                          color: AppColorConstant.black,
                          size: 80.0,
                          height: 0.5,
                        ),
                        const SizedBox(height: 40),
                        const BodyText(
                          text:
                              'Geet has a decade of experience in the hair and makeup industry, including as a freelance artist.\n Geet is incredibly passionate about her craft, and in ensuring that each of Makeup Star Studio\'s brides look and feel their best with every look that she creates!',
                        ),
                        const SizedBox(height: 20),
                        ModifiedButton(
                          text: 'Get in Touch',
                          press: () {
                            Navigator.pushNamed(
                                context, WebsiteRoute.bookRoute);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // Second expanded section
                Expanded(
                  child: Container(
                    height: 659,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: image.isNotEmpty
                              ? NetworkImage(image[6].url) as ImageProvider
                              : const AssetImage('assets/images/contact.webp')
                                  as ImageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text('No Data');
          }
        }
      },
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenSize.height * 0.75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: image.isNotEmpty
                            ? NetworkImage(image[5].url) as ImageProvider
                            : const AssetImage('assets/images/image.webp')
                                as ImageProvider,
                        fit: BoxFit.cover),
                  ),
                ),
                //text
                Container(
                  // height: screenSize.height,
                  decoration: const BoxDecoration(
                    color: AppColorConstant.buttonColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const BigText(
                        text: 'bridal makeup & hair',
                        // size: 30.0,
                        height: 1.0,
                      ),
                      const SubHeadingSlanted(
                        text: 'by Geet',
                        color: AppColorConstant.black,
                        // size: 80.0,
                        height: 0.5,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const BodyText(
                        text:
                            'Geet has a decade of experience in the hair and makeup industry, including as a freelance artist.\n Geet is incredibly passionate about her craft, and in ensuring that each of Makeup Star Studio\'s brides look and feel their best with every look that she creates!',
                      ),
                      const SizedBox(height: 20),
                      ModifiedButton(
                          text: 'Get in Touch',
                          press: () {
                            Navigator.pushNamed(
                                context, WebsiteRoute.bookRoute);
                          }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('No Data');
          }
        }
      },
    );
  }
}
