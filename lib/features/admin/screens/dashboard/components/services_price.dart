import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/features/admin/models/service_pricing.dart';

class ServicesPricing extends StatelessWidget {
  const ServicesPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: const BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Services",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: AppColorConstant.defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text(
                    "S.No.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Service Name",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Price",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Category",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const DataColumn(
                  label: Text(""),
                ),
              ],
              rows: List.generate(
                demoServicesPricing.length,
                (index) => serviceInfoDataRow(demoServicesPricing[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow serviceInfoDataRow(AboutServices serviceInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text(serviceInfo.id.toString()),
      ),
      DataCell(
        Text(serviceInfo.title!),
      ),
      DataCell(Text(serviceInfo.price!)),
      DataCell(Text(serviceInfo.category!)),
      DataCell(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(serviceInfo.editButton),
                onPressed: () {},
                color: AppColorConstant.successColor,
              ),
            ),
            const SizedBox(width: AppColorConstant.defaultPadding / 2),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(serviceInfo.dltButton),
                onPressed: () {},
                color: AppColorConstant.errorColor,
              ),
            ),
            const SizedBox(width: AppColorConstant.defaultPadding / 2),
          ],
        ),
      ),
    ],
  );
}
