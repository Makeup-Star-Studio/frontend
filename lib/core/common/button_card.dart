import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(color: AppColorConstant.buttonColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
