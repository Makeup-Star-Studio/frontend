import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/bookings/admin_booking_view.dart';
import 'package:makeupstarstudio/features/admin/screens/clients/clients.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/dashboard_screen.dart';
import 'package:makeupstarstudio/features/admin/screens/finance/finance.dart';
import 'package:makeupstarstudio/features/admin/screens/message/message.dart';
import 'package:makeupstarstudio/features/admin/screens/services/services.dart';
import 'package:makeupstarstudio/features/admin/screens/settings/settings.dart';
import 'package:makeupstarstudio/features/admin/screens/team/team.dart';

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
    const AdminClientsView(),
    const AdminGlamTeamView(),
    const AdminMessagesView(),
    const AdminServicesView(),
    const AdminFinanceView(),
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
        // key: context.read<MenuAppController>().scaffoldKey,
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
                // child: DashboardScreen(),
                child: _screens[widget.selectedIndex], // Show selected screen
              ),
            ],
          ),
        ),
      ),
    );
  }
}
