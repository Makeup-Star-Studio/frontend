import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/features/home/components/service_card.dart';

class ServiceSection extends StatelessWidget {
  const ServiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize),
      mediumScreen: _buildMediumScreen(screenSize),
      smallScreen: _buildSmallScreen(screenSize),
    );
  }

  Widget _buildLargeScreen(Size screenSize) {
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
            children: const [
              ServiceCard(
                  title: 'Bridal', imagePath: 'assets/images/service4.jpg'),
              ServiceCard(
                  title: 'Makeup', imagePath: 'assets/images/service1.jpg'),
              ServiceCard(
                  title: 'Hair', imagePath: 'assets/images/service2.jpg'),
              ServiceCard(
                  title: 'Henna', imagePath: 'assets/images/service3.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediumScreen(Size screenSize) {
    return _buildLargeScreen(screenSize);
  }

  Widget _buildSmallScreen(Size screenSize) {
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
            children: const [
              ServiceCard(
                  title: 'Bridal', imagePath: 'assets/images/service4.jpg'),
              ServiceCard(
                  title: 'Makeup', imagePath: 'assets/images/service1.jpg'),
              ServiceCard(
                  title: 'Hair', imagePath: 'assets/images/service2.jpg'),
              ServiceCard(
                  title: 'Henna', imagePath: 'assets/images/service3.jpg'),
            ],
          ),
        ],
      ),
    );
  }
}
