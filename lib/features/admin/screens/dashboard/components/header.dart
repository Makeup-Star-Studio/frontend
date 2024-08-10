import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/logout_screen.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:provider/provider.dart';

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
          Text(
            "Overview of the Admin Panel",
            style: ResponsiveWidget.isSmallScreen(context)
                ? Theme.of(context).textTheme.titleSmall
                : Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(width: 20.0),
          // const Observation(),
          if (!ResponsiveWidget.isSmallScreen(context))
            Spacer(flex: ResponsiveWidget.isLargeScreen(context) ? 2 : 1),
          const ProfileCard(),
        ],
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.fetchUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return const CircularProgressIndicator();
        } else {
          final userProvider = Provider.of<UserProvider>(context);
          final userModel = userProvider.user;

          // Debugging: Print the user data
          print('UserModel data: $userModel');

          if (userModel == null) {
            return const Center(child: Text("No User Found"));
          }

          final user = userModel.data.user;
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppColorConstant.defaultPadding,
            ),
            decoration: BoxDecoration(
              color: AppColorConstant.adminSecondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: user.imageUrl.isNotEmpty
                              ? NetworkImage(
                                  'https://makeup-star-studio.sfo2.digitaloceanspaces.com/admin/${user.imageUrl}',
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 20,
                                ) as ImageProvider,
                        ),
                        const SizedBox(width: AppColorConstant.defaultPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fname.isNotEmpty
                                  ? user.fname
                                  : user.username,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              "Admin",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Colors.black38, fontSize: 12.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                            width: AppColorConstant.defaultPadding / 2),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onPressed: _toggleLogoutVisibility,
                        ),
                      ],
                    ),
                  ],
                ),
                if (_isLogoutVisible)
                  Positioned(
                    top: 0,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        showLogoutConfirmationDialog(context);
                      },
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: AppColorConstant.adminPrimaryColor,
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
                            color: AppColorConstant.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}
