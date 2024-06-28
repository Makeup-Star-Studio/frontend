import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/components/header.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/components/overview.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/components/services_price.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/components/upcoming_bookings.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: AppColorConstant.defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        const Overview(),
                        const SizedBox(height: AppColorConstant.defaultPadding),
                        const ServicesPricing(),
                        if (ResponsiveWidget.isSmallScreen(context) ||
                            ResponsiveWidget.isMediumScreen(context))
                          const SizedBox(
                            height: AppColorConstant.defaultPadding,
                          ),
                        if (ResponsiveWidget.isSmallScreen(context) ||
                            ResponsiveWidget.isMediumScreen(context))
                          const BookingDetails(),
                      ],
                    ),
                  ),
                  if (!ResponsiveWidget.isSmallScreen(context) &&
                      !ResponsiveWidget.isMediumScreen(context))
                    const SizedBox(width: AppColorConstant.defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                  if (!ResponsiveWidget.isSmallScreen(context) &&
                      !ResponsiveWidget.isMediumScreen(context))
                    const Expanded(
                      flex: 2,
                      child: BookingDetails(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
