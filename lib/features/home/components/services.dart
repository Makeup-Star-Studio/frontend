import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/features/home/components/service_card.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/provider/services/services_provider.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
import 'package:provider/provider.dart';

class ServiceSection extends StatefulWidget {
  const ServiceSection({super.key});

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServicesProvider>(context, listen: false).fetchAllServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final List<Service> services =
        Provider.of<ServicesProvider>(context).services;

    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize),
      mediumScreen: _buildMediumScreen(screenSize),
      smallScreen: _buildSmallScreen(screenSize),
    );
  }

  Widget _buildLargeScreen(Size screenSize) {
    return Consumer<ServicesProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (value.services.isEmpty) {
            return const Center(child: Text('No services available'));
          }
          final List<Service> services = value.services;
          return Container(
            padding: EdgeInsets.only(
                left: screenSize.width * 0.1,
                right: screenSize.width * 0.1,
                bottom: 20.0),
            child: Column(
              children: [
                const SubHeadingSlanted(
                  text: 'Explore our beauty services',
                  size: 80.0,
                ),
                const SizedBox(height: 10.0),
                GridView.count(
                  crossAxisCount: 4, // Adjust the number of columns as needed
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ServiceCard(
                        title: 'Bridal',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Bridal').image}'),
                    ServiceCard(
                        title: 'Hair',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Hair').image}'),
                    ServiceCard(
                        title: 'Henna',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Henna').image}'),
                    ServiceCard(
                        title: 'Draping',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Draping').image}'),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildMediumScreen(Size screenSize) {
    return _buildLargeScreen(screenSize);
  }

  Widget _buildSmallScreen(Size screenSize) {
    return Consumer<ServicesProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final List<Service> services = value.services;
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SubHeadingSlanted(
                  text: 'Explore our beauty services',
                  // size: 80.0,
                  height: 1.0,
                ),
                const SizedBox(height: 20.0),
                GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 1, // Adjust the number of columns as needed
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: 0.8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ServiceCard(
                        title: 'Bridal',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Bridal').image}'),
                    ServiceCard(
                        title: 'Hair',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Hair').image}'),
                    ServiceCard(
                        title: 'Henna',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Henna').image}'),
                    ServiceCard(
                        title: 'Draping',
                        imagePath:
                            '${ApiConstant.localUrl}/services/${services.firstWhere((element) => element.category == 'Draping').image}'),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
