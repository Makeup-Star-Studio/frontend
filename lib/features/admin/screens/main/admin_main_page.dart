import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/controllers/menu_controller.dart';
import 'package:makeupstarstudio/features/admin/screens/bookings/admin_booking_view.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0; // Initially selected index

  final List<Widget> _screens = [
    DashboardScreen(),
    AdminBookingViewPage(),
    // Add other screens here as needed
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
        key: context.read<MenuAppController>().scaffoldKey,
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (ResponsiveWidget.isLargeScreen(context))
                const Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: _screens[_selectedIndex], // Show selected screen
              ),
            ],
          ),
        ),
      ),
    );
  }
}
