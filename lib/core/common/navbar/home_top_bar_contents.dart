import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';

class HomeTopBarContents extends StatefulWidget {
  const HomeTopBarContents({super.key});

  @override
  _HomeTopBarContentsState createState() => _HomeTopBarContentsState();
}

class _HomeTopBarContentsState extends State<HomeTopBarContents> {
  final List<bool> _isHovering = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      // color: Colors.white.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  Navigator.pushNamed(context, '');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 75,
                      height: 75,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(width: screenSize.width / 5),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onTap:() {
                      Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
                    },
                    onHover: (value) {
                      setState(() {
                        _isHovering[0] = value;
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ABOUT',
                          style: TextStyle(
                            color: _isHovering[0]
                                ? AppColorConstant.secondaryColor
                                : Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 30),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onHover: (value) {
                      setState(() {
                        _isHovering[1] = value;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SERVICES',
                          style: TextStyle(
                            color: _isHovering[1]
                                ? AppColorConstant.secondaryColor
                                : Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 30),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onHover: (value) {
                      setState(() {
                        _isHovering[2] = value;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'BRIDAL',
                          style: TextStyle(
                            color: _isHovering[2]
                                ? AppColorConstant.secondaryColor
                                : Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 30),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onHover: (value) {
                      setState(() {
                        _isHovering[3] = value;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'GALLERY',
                          style: TextStyle(
                            color: _isHovering[3]
                                ? AppColorConstant.secondaryColor
                                : Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenSize.width / 30),
                  InkWell(
                    hoverColor: Colors.transparent,
                    onHover: (value) {
                      setState(() {
                        _isHovering[4] = value;
                      });
                    },
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'CONTACT',
                          style: TextStyle(
                            color: _isHovering[4]
                                ? AppColorConstant.secondaryColor
                                : Colors.black,
                            // fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                hoverColor: Colors.transparent,
                onHover: (value) {
                  setState(() {
                    _isHovering[5] = value;
                  });
                },
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: const BoxDecoration(
                          color: AppColorConstant.buttonColor),
                      child: Row(
                        children: [
                          const Text(
                            'BOOK APPOINTMENT',
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                          // SizedBox(width: 10),
                          IconButton(
                            hoverColor: Colors.transparent,
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_right_alt_sharp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}