import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/models/overview.dart';

class OverViewInfoCard extends StatelessWidget {
  const OverViewInfoCard({
    super.key,
    required this.info,
  });

  final OverViewInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: const BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? OverViewContainerSmallScreen(info: info)
          : OverViewContainerLargeScreen(info: info),
    );
  }
}

class OverViewContainerLargeScreen extends StatelessWidget {
  const OverViewContainerLargeScreen({super.key, required this.info});
  final OverViewInfo info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(AppColorConstant.defaultPadding * 0.75),
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: info.color!.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: SvgPicture.asset(
          info.svgSrc!,
          colorFilter:
              ColorFilter.mode(info.color ?? Colors.black, BlendMode.srcIn),
        ),
      ),
      title: Text(
        info.title!,
        style: const TextStyle(
          color: AppColorConstant.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text("${info.count}",
          style: const TextStyle(
            color: AppColorConstant.black,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          )),
      trailing: const Icon(Icons.more_vert, color: Colors.black),
    );
  }
}

class OverViewContainerSmallScreen extends StatelessWidget {
  const OverViewContainerSmallScreen({super.key, required this.info});
  final OverViewInfo info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  const EdgeInsets.all(AppColorConstant.defaultPadding * 0.75),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: info.color!.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                info.svgSrc!,
                colorFilter: ColorFilter.mode(
                    info.color ?? Colors.black, BlendMode.srcIn),
              ),
            ),
            const Icon(Icons.more_vert, color: Colors.black)
          ],
        ),
        const SizedBox(height: AppColorConstant.defaultPadding / 2),
        Text(
          info.title!,
          style: const TextStyle(
            color: AppColorConstant.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppColorConstant.defaultPadding / 2),
        Text('${info.count}',
            style: const TextStyle(
              color: AppColorConstant.black,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ))
      ],
    );
  }
}
