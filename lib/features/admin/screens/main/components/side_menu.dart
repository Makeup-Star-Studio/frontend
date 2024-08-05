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
            child: SizedBox(
              child: Image.asset(
                "assets/images/logo-black.png",
                color: AppColorConstant.white,
                height: 100,
              ),
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/svgs/dashboard.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 0);
              }));
            },
          ),
          DrawerListTile(
            title: "Bookings",
            svgSrc: "assets/svgs/booking.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 1);
              }));
            },
          ),
          // DrawerListTile(
          //   title: "Message",
          //   svgSrc: "assets/svgs/menu_store.svg",
          //   press: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return const AdminPage(selectedIndex: 4);
          //     }));
          //   },
          // ),
          DrawerListTile(
            title: "Services",
            svgSrc: "assets/svgs/services.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 2);
              }));
            },
          ),
          DrawerListTile(
            title: "Portfolio",
            svgSrc: "assets/svgs/portfolio.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 3);
              }));
            },
          ),
          DrawerListTile(
            title: "Testimonials",
            svgSrc: "assets/svgs/review.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 4);
              }));
            },
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/svgs/setting.svg",
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AdminPage(selectedIndex: 5);
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
