import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/text/body.dart';
import 'package:makeupstarstudio/theme/color.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: AppColorConstant.bgColor,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: BodyText(
            text: '© 2024 Makeup Star Studio. All Rights Reserved.',
          ),
        ));
  }
}
