import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 600,
            child: Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(250.0),
                  topLeft: Radius.circular(250.0),
                ),
                child: Image.asset(
                  'assets/images/image.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50.0,
          ),
          SizedBox(
            width: 500,
            child: Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'MAKEUP STAR STUDIO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Cradley',
                      fontSize: 40.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'elevating beauty & confidence',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sebastian Bobby',
                      fontSize: 50.0,
                      color: Color(0xffAB8F77),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Hello, Im Geetanjali, a lead artist of Makeup Star Studio. Our mission is to connect the clients with our team of talented beauty professionals to provide luxury on site beauty services while elevating your beauty and confidence. We want to provide you the luxury of having your own beauty squad to take care of all your beauty needs from Hair Extensions to Saree Drapping, in the most convenient way possible - In the comfort of your home or location of your choice.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'KNOW MORE ABOUT US',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        fontSize: 14.0,
                      ),
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
}
