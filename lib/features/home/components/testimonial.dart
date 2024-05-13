import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _testimonials = [
    {
      'bigText': '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
      'bodyText':
          'I hired Makeup Star Studio for my wedding, I am so happy that I did. My hair and make up was incredible and all of my bridesmaids were so happy with how everything turned out. There were no tears over hair and make up that day! It was everything a bride could ask for. They were so skilled and efficient that we ran ahead of schedule and I had almost zero stress on my wedding day. The stylists are so talented and polite that I could not have found a better place. I highly recommend hiring them for your big day or any beauty needs!!',
      'name': 'JENNA',
      'imagePath': 'assets/images/testimonial.jpg',
    },
    {
      'bigText': '"DO NOT LOOK ANYWHERE ELSE FOR WEDDING MAKE-UP"',
      'bodyText':
          'Do not look anywhere else for wedding make-up. Call and book, ASAP. Cannot say enough amazing things about Geet. Hired Makeup Star Studio for my wedding to do make-up for myself, mom, 4 bridesmaids and 2 flower girls. Grace and Hayley were our make-up artists and were wonderful. Kind, friendly and talented! Everyone loved their make-up and I was beyond happy with mine - it was perfect!',
      'name': 'PREETI',
      'imagePath': 'assets/images/service1.jpg',
    },
    {
      'bigText': '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
      'bodyText':
          'I hired Mane Chic for my wedding, I am so happy that I did. My hair and make up was incredible and all of my bridesmaids were so happy with how everything turned out. There were no tears over hair and make up that day! It was everything a bride could ask for. They were so skilled and efficient that we ran ahead of schedule and I had almost zero stress on my wedding day. The stylists are so talented and polite that I could not have found a better place. I highly recommend hiring them for your big day or any beauty needs!!',
      'name': 'JENNA',
      'imagePath': 'assets/images/testimonial.jpg',
    },
    // Add more testimonials as needed
  ];

  void _nextTestimonial() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _testimonials.length;
    });
  }

  void _previousTestimonial() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % _testimonials.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final testimonial = _testimonials[_currentIndex];
    final screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(testimonial),
      mediumScreen: _buildMediumScreen(screenSize, testimonial),
      smallScreen: _buildSmallScreen(screenSize, testimonial),
    );
  }

  Widget _buildLargeScreen(Map<String, dynamic> testimonial) {
    return Container(
      color: AppColorConstant.bgColor,
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SubHeadingSlanted(
                  textAlign: TextAlign.start,
                  text: 'Client Love',
                  size: 65.0,
                  color: AppColorConstant.black,
                ),
                const SizedBox(height: 50.0),
                BigText(
                  textAlign: TextAlign.start,
                  text: testimonial['bigText'],
                  size: 25.0,
                ),
                const SizedBox(height: 20.0),
                BodyText(
                  textAlign: TextAlign.start,
                  text: testimonial['bodyText'],
                ),
                const SizedBox(height: 20.0),
                BodyText(
                  text: testimonial['name'],
                  color: AppColorConstant.subHeadingColor,
                  size: 16.0,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20.0),
          Stack(
            children: [
              ClipRect(
                child: Image.asset(
                  testimonial['imagePath'],
                  width: 750.0,
                  height: 750.0,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 3,
                left: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColorConstant.iconBgColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: _previousTestimonial,
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: AppColorConstant.black,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      IconButton(
                        hoverColor: Colors.transparent,
                        onPressed: _nextTestimonial,
                        icon: const Icon(
                          Icons.arrow_forward_sharp,
                          color: AppColorConstant.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMediumScreen(Size screenSize, Map<String, dynamic> testimonial) {
    return _buildSmallScreen(screenSize, testimonial);
  }

  Widget _buildSmallScreen(Size screenSize, Map<String, dynamic> testimonial) {
    return Column(
      children: [
        Image.asset(
          testimonial['imagePath'],
          width: screenSize.width,
          height: 500.0,
          fit: BoxFit.cover,
        ),
        // const SizedBox(height: 20.0),
        Container(
          color: AppColorConstant.bgColor,
          padding: const EdgeInsets.all(20.0),
          // Use Container instead of SizedBox
          // height: screenSize.height * 0.5, // Specify a finite height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SubHeadingSlanted(
                textAlign: TextAlign.start,
                text: 'Client Love',
                size: 65.0,
                height: 1.0,
                color: AppColorConstant.black,
              ),
              const SizedBox(height: 20.0),
              BigText(
                // textAlign: TextAlign.start,
                text: testimonial['bigText'],
                size: 25.0,
              ),
              const SizedBox(height: 20.0),
              BodyText(
                // textAlign: TextAlign.start,
                text: testimonial['bodyText'],
              ),
              const SizedBox(height: 20.0),
              BodyText(
                text: testimonial['name'],
                color: AppColorConstant.subHeadingColor,
                // size: 16.0,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    hoverColor: Colors.transparent,
                    onPressed: _previousTestimonial,
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: AppColorConstant.black,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  IconButton(
                    hoverColor: Colors.transparent,
                    onPressed: _nextTestimonial,
                    icon: const Icon(
                      Icons.arrow_forward_sharp,
                      color: AppColorConstant.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
