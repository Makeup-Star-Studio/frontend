import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
import 'package:provider/provider.dart';

class NonBridalHairServiceSection extends StatefulWidget {
  const NonBridalHairServiceSection({super.key});

  @override
  NonBridalHairServiceSectionState createState() =>
      NonBridalHairServiceSectionState();
}

class NonBridalHairServiceSectionState
    extends State<NonBridalHairServiceSection> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NonBridalHairServicesProvider>(context, listen: false)
          .fetchNonBridalHairServices();
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

  // large screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
    return Consumer<NonBridalHairServicesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.15, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/service2.jpg',
                      width: 350,
                      height: screenSize.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Container(
                    width: 350,
                    height: screenSize.height,
                    decoration: BoxDecoration(
                      color: AppColorConstant.white,
                      border: Border.all(
                        color: AppColorConstant.secondaryColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const BigText(
                            text: 'Hair Styling',
                            height: 1.0,
                            size: 30.0,
                          ),
                          const SubHeadingSlanted(
                              text: "what's included", height: 1.0),
                          const SizedBox(height: 20.0),
                          const BodyText(
                              text:
                                  "Discover the art of flawless hairstyling at Makeup Star Studio. From chic curls to stunning updos, our expert stylists craft personalized looks tailored to your unique beauty."),
                          const SizedBox(height: 20.0),

                          // get data from api
                          _buildServiceList(provider.services),

                          // RichText(
                          //   text: const TextSpan(
                          //     style: TextStyle(
                          //       fontFamily: 'Questrial',
                          //       height: 1.75,
                          //       fontSize: 16.0,
                          //     ),
                          //     children: [
                          //       TextSpan(
                          //           text: "- HAIRSTYLING/ FORMAL STYLE | \$105+\n"),
                          //       TextSpan(text: "- BLOWOUT | \$105+\n"),
                          //       TextSpan(text: "- BLOWOUT & STYLE | \$165+\n"),
                          //       TextSpan(text: "- HAIR EXTENSIONS | \$200+\n"),
                          //       TextSpan(text: "- HAIR TRIAL | \$110+\n"),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(height: 20.0),
                          const BodyText(
                            text: "Travel Fee: according to location",
                            size: 18.0,
                            color: AppColorConstant.subHeadingColor,
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: 300,
                            child: ButtonCard(
                              text: 'BOOK APPOINTMENT',
                              press: () {
                                Navigator.pushNamed(
                                    context, WebsiteRoute.bookRoute);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Widget to build service list
  Widget _buildServiceList(List<Service> services) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Questrial',
          height: 1.75,
          fontSize: 16.0,
        ),
        children: services
            .map((service) => TextSpan(
                  text:
                      "- ${service.title} | \$${service.price.toStringAsFixed(2)}+\n",
                ))
            .toList(),
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Consumer<NonBridalHairServicesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/images/service2.jpg',
                    width: screenSize.width,
                    height: screenSize.height,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20.0),
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  decoration: const BoxDecoration(
                    color: AppColorConstant.white,
                    border: Border(
                      left: BorderSide(
                        color: AppColorConstant.secondaryColor,
                        width: 1,
                      ),
                      right: BorderSide(
                        color: AppColorConstant.secondaryColor,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: AppColorConstant.secondaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const BigText(
                          text: 'Hair Styling',
                          height: 1.0,
                          mediumSize: 30.0,
                        ),
                        const SubHeadingSlanted(
                            text: "what's included", height: 1.0),
                        const SizedBox(height: 20.0),
                        const BodyText(
                            text:
                                "Discover the art of flawless hairstyling at Makeup Star Studio. From chic curls to stunning updos, our expert stylists craft personalized looks tailored to your unique beauty."),
                        const SizedBox(height: 20.0),

                        // get data from api
                        _buildServiceList(provider.services),

                        // RichText(
                        //   textAlign: TextAlign.center,
                        //   text: const TextSpan(
                        //     style: TextStyle(
                        //       color: AppColorConstant.black,
                        //       fontFamily: 'Questrial',
                        //       height: 1.75,
                        //       fontSize: 16.0,
                        //     ),
                        //     children: [
                        //       TextSpan(
                        //           text: "- HAIRSTYLING/ FORMAL STYLE | \$105+\n"),
                        //       TextSpan(text: "- BLOWOUT | \$105+\n"),
                        //       TextSpan(text: "- BLOWOUT & STYLE | \$165+\n"),
                        //       TextSpan(text: "- HAIR EXTENSIONS | \$200+\n"),
                        //       TextSpan(text: "- HAIR TRIAL | \$110+"),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 20.0),
                        const BodyText(
                          text: "Travel Fee: according to location",
                          smallSize: 18.0,
                          color: AppColorConstant.subHeadingColor,
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: 300,
                          child: ButtonCard(
                            text: 'BOOK APPOINTMENT',
                            press: () {
                              Navigator.pushNamed(
                                  context, WebsiteRoute.bookRoute);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
