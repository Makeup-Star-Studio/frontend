import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/features/admin/controllers/menu_controller.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:provider/provider.dart';

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
              Navigator.pop(context); // Close the drawer
              Provider.of<MenuAppController>(context, listen: false).setSelectedIndex(0);
            },
          ),
          DrawerListTile(
            title: "Bookings",
            svgSrc: "assets/svgs/menu_tran.svg",
            press: () {
              // Navigator.pop(context); // Close the drawer
              Provider.of<MenuAppController>(context, listen: false)
                  .setSelectedIndex(1);
            },
          ),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/svgs/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Glam Team",
            svgSrc: "assets/svgs/menu_doc.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Message",
            svgSrc: "assets/svgs/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Services",
            svgSrc: "assets/svgs/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Finance",
            svgSrc: "assets/svgs/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/svgs/menu_setting.svg",
            press: () {},
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
