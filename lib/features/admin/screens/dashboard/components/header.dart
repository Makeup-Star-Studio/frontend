import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/controllers/menu_controller.dart';
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
              onPressed: context.read<MenuAppController>().controlMenu,
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
          const Row(
            children: [SearchField(), ProfileCard()],
          ),
        ],
      ),
    );
  }
}

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

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: AppColorConstant.defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: AppColorConstant.defaultPadding,
        // vertical: AppColorConstant.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),

            const SizedBox(width: AppColorConstant.defaultPadding),
            // if (!ResponsiveWidget.isSmallScreen(context))
            // dropdown
            DropdownButton(
              underline: const SizedBox(),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: const [
                DropdownMenuItem(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColorConstant.black,
                    ),
                  ),
                ),
              ],
              onChanged: (value) {},
            ),

            // const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
    );
  }
}

    // TextField(
    //   decoration: InputDecoration(
    //     hintText: "Search",
    //     fillColor: AppColorConstant.adminSecondaryColor,
    //     filled: true,
    //     border: const OutlineInputBorder(
    //       borderSide: BorderSide.none,
    //       borderRadius: BorderRadius.all(Radius.circular(10)),
    //     ),
    //     suffixIcon: InkWell(
    //       onTap: () {},
    //       child: Container(
    //         padding:
    //             const EdgeInsets.all(AppColorConstant.defaultPadding * 0.75),
    //         margin: const EdgeInsets.symmetric(
    //             horizontal: AppColorConstant.defaultPadding / 2),
    //         decoration: const BoxDecoration(
    //           color: AppColorConstant.adminPrimaryColor,
    //           borderRadius: BorderRadius.all(Radius.circular(10)),
    //         ),
    //         child: SvgPicture.asset("assets/icons/Search.svg"),
    //       ),
    //     ),
    //   ),
    // );