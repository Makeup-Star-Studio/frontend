import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/logout_screen.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.circular(AppColorConstant.defaultPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!ResponsiveWidget.isLargeScreen(context))
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          if (!ResponsiveWidget.isSmallScreen(context))
            Text(
              "Overview",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          const SizedBox(width: 20.0),
          const Observation(),
          if (!ResponsiveWidget.isSmallScreen(context))
            Spacer(flex: ResponsiveWidget.isLargeScreen(context) ? 2 : 1),
          const ProfileCard(),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Observation                            */

class Observation extends StatefulWidget {
  const Observation({super.key});

  @override
  State<Observation> createState() => _ObservationState();
}

class _ObservationState extends State<Observation> {
  final List<String> observationOptions = [
    "Today",
    "Last 7 Days",
    "Last 30 Days",
  ];
  String selectedObservedOption = "Last 7 Days";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButton(
        // padding: EdgeInsets.only(top: 8),
        // isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 0,
        underline: const SizedBox(),
        value: selectedObservedOption,
        items: observationOptions.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                )),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedObservedOption = newValue.toString();
          });
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Profile Card                            */

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _isLogoutVisible = false;

  void _toggleLogoutVisibility() {
    setState(() {
      _isLogoutVisible = !_isLogoutVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppColorConstant.defaultPadding,
      ),
      decoration: BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              const SizedBox(width: AppColorConstant.defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Geet",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "Admin",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black38, fontSize: 12.0),
                  ),
                ],
              ),
              const SizedBox(width: AppColorConstant.defaultPadding / 2),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down),
                onPressed: _toggleLogoutVisibility,
              ),
            ],
          ),
          if (_isLogoutVisible)
     Positioned(
  top: 0,
  right: 0,
  child: GestureDetector(
    onTap: () {
      showLogoutConfirmationDialog(context);
    },
    child: Container(
      width: 120,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Text(
        "Logout",
        style: TextStyle(
          fontSize: 14,
          color: AppColorConstant.black,
        ),
      ),
    ),
  ),
),



        ],
      ),
    );
  }
}
