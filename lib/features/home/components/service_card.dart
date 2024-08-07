import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String imagePath;

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onTap: () {
        // Handle onTap event if needed
        Navigator.pushNamed(context, WebsiteRoute.servicesRoute);
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
            // Decrease the opacity of the image
            Opacity(
              opacity: 0.8, // Adjust the opacity here (0.0 - 1.0)
              child: Image.network(
                widget.imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay with light color on hover
            if (_isHovered)
              Container(
                color: Colors.black
                    .withOpacity(0.3), // Light color to show on hover
                width: double.infinity,
                height: double.infinity,
              ),
            Center(
              child: BigText(
                text: widget.title,
                size: 30.0,
                color: _isHovered
                    ? AppColorConstant.warningColor
                    : AppColorConstant.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
