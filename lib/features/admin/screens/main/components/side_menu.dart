import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColorConstant.adminPrimaryColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/logo-black.png",
              color: AppColorConstant.white,
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/svgs/menu_dashboard.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 0);
              }));
            },
          ),
          DrawerListTile(
            title: "Bookings",
            svgSrc: "assets/svgs/menu_tran.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 1);
              }));
            },
          ),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/svgs/menu_task.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 2);
              }));
            },
          ),
          DrawerListTile(
            title: "Glam Team",
            svgSrc: "assets/svgs/menu_doc.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 3);
              }));
            },
          ),
          DrawerListTile(
            title: "Message",
            svgSrc: "assets/svgs/menu_store.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 4);
              }));
            },
          ),
          DrawerListTile(
            title: "Services",
            svgSrc: "assets/svgs/menu_notification.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 5);
              }));
            },
          ),
          DrawerListTile(
            title: "Finance",
            svgSrc: "assets/svgs/menu_profile.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 6);
              }));
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/svgs/menu_setting.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 7);
              }));
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
