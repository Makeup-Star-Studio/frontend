import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/text/heading.dart';
import 'package:makeupstarstudio/theme/color.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String imagePath;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle onTap event if needed
      },
      onHover: (isHovered) {
        setState(() {
          _isHovered = isHovered;
        });
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Stack(
          children: [
            Image.asset(
              widget.imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            if (_isHovered)
              Container(
                color: Colors.white
                    .withOpacity(0.3), // Light color to show on hover
                width: double.infinity,
                height: double.infinity,
              ),
            Center(
              child: BigText(
                text: widget.title,
                size: 30.0,
                color: AppColorConstant.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
