import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/services/services_provider.dart';
import 'package:provider/provider.dart';

class OverViewInfoCard1 extends StatefulWidget {
  const OverViewInfoCard1({
    super.key,
  });

  @override
  State<OverViewInfoCard1> createState() => _OverViewInfoCard1State();
}

class _OverViewInfoCard1State extends State<OverViewInfoCard1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServicesProvider>(context, listen: false).fetchAllServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: const BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? const OverViewContainerSmallScreen()
          : const OverViewContainerLargeScreen(),
    );
  }
}

class OverViewContainerLargeScreen extends StatelessWidget {
  const OverViewContainerLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
        builder: (context, servicesProvider, child) {
      final services = servicesProvider.services;
      if (servicesProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppColorConstant.defaultPadding * 0.75),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFA4CDFF).withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: SvgPicture.asset(
            'assets/svgs/one_drive.svg',
            // colorFilter: const ColorFilter.mode(Color(0xFFA4CDFF), BlendMode.srcIn),
          ),
        ),
        title: const Text(
          'Services',
          style: TextStyle(
            color: AppColorConstant.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text("${services.length}",
            style: const TextStyle(
              color: AppColorConstant.black,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            )),
        trailing: const Icon(Icons.more_vert, color: Colors.black),
      );
    });
  }
}

class OverViewContainerSmallScreen extends StatelessWidget {
  const OverViewContainerSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
        builder: (context, servicesProvider, child) {
      final services = servicesProvider.services;
      if (servicesProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(
                    AppColorConstant.defaultPadding * 0.75),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColorConstant.adminBgColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/svgs/one_drive.svg',
                  // colorFilter: const ColorFilter.mode(
                  //     AppColorConstant.black ?? Colors.black, BlendMode.srcIn),
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.black)
            ],
          ),
          const SizedBox(height: AppColorConstant.defaultPadding / 2),
          const Text(
            'Services',
            style: TextStyle(
              color: AppColorConstant.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppColorConstant.defaultPadding / 2),
          Text('${services.length}',
              style: const TextStyle(
                color: AppColorConstant.black,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ))
        ],
      );
    });
  }
}
