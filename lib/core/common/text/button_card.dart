import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';

class ButtonCard extends StatelessWidget {
  final String text;
  final void Function() press;

  const ButtonCard({
    super.key,
    this.text = 'BOOK APPOINTMENT',
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(color: AppColorConstant.buttonColor),
      child: GestureDetector(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_right_alt_sharp)
          ],
        ),
      ),
    );
  }
}
