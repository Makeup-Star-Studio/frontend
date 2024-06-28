import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class AdminBookingViewPage extends StatelessWidget {
  const AdminBookingViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!ResponsiveWidget.isLargeScreen(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        const Center(
          child: Text('Admin Booking View Page'),
        ),
      ],
    );
  }
}
