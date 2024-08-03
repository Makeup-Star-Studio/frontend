import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/bookings/admin_booking_view.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:makeupstarstudio/features/admin/screens/services/admin_services.dart';
import 'package:makeupstarstudio/features/admin/screens/settings/settings.dart';
import 'package:makeupstarstudio/features/admin/screens/team/team.dart';
import 'package:makeupstarstudio/features/admin/screens/testimonials/admin_testimonials.dart';

import 'components/side_menu.dart';

class AdminPage extends StatefulWidget {
  final int selectedIndex;

  const AdminPage({this.selectedIndex = 0, super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<Widget> _screens = [
    const DashboardScreen(),
    const AdminBookingViewPage(),
    const AdminServicesView(),
    const AdminGlamTeamView(),
    const AdminTestimonialsView(),
    const AdminSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColorConstant.adminBgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: AppColorConstant.adminSecondaryColor,
      ),
      child: Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ResponsiveWidget.isLargeScreen(context))
                const Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: _screens[widget.selectedIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
