import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/models/overview.dart';
import 'package:makeupstarstudio/features/admin/screens/dashboard/components/overview_info_card.dart';

class Overview extends StatelessWidget {
  const Overview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return const Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "My Files",
        //       style: Theme.of(context).textTheme.titleMedium,
        //     ),
        //     ElevatedButton.icon(
        //       style: TextButton.styleFrom(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: AppColorConstant.defaultPadding * 1.5,
        //           vertical: AppColorConstant.defaultPadding /
        //               (ResponsiveWidget.isSmallScreen(context) ? 2 : 1),
        //         ),
        //       ),
        //       onPressed: () {},
        //       icon: const Icon(Icons.add),
        //       label: const Text("Add New"),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: AppColorConstant.defaultPadding),
        InfoCardGridView()
      ],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    super.key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 4,
  });

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoOverView.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppColorConstant.defaultPadding,
        mainAxisSpacing: AppColorConstant.defaultPadding,
        childAspectRatio: ResponsiveWidget.isSmallScreen(context)
            ? 1.2
            : ResponsiveWidget.isMediumScreen(context)
                ? 2
                : childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          OverViewInfoCard(info: demoOverView[index]),
    );
  }
}
