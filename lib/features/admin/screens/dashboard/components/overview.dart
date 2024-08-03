import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/widget/overview2.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/widget/overview3.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/widget/overview_info_card.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return const Column(
      children: [InfoCardGridView()],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    super.key,
    this.crossAxisCount = 1,
    this.childAspectRatio = 6,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppColorConstant.defaultPadding,
        mainAxisSpacing: AppColorConstant.defaultPadding,
        childAspectRatio: ResponsiveWidget.isSmallScreen(context)
            ? 2
            : ResponsiveWidget.isMediumScreen(context)
                ? childAspectRatio
                : childAspectRatio,
      ),
      itemBuilder: (context, index) => index == 0
          ? const OverViewInfoCard1()
          : index == 1
              ? const OverViewInfoCard2()
              : const OverViewInfoCard3(),
    );
  }
}
