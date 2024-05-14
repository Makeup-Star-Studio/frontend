import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class GallerySlide2 extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/image.jpeg',
    'assets/images/contact.png',
    'assets/images/service1.jpg',
    'assets/images/service2.jpg',
    'assets/images/service3.jpg',
    'assets/images/service4.jpg',
  ];

  GallerySlide2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        // aspectRatio: 16 / 9,
        viewportFraction: ResponsiveWidget.isSmallScreen(context)
            ? 1 / 2
            : 1 / 3, // Display three images at once
        enlargeCenterPage: false,
      ),
      items: imageUrls.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 500, // Width of each image
              height: screenSize.height,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
