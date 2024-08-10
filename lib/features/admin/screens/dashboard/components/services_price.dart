import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/services/services_provider.dart';
import 'package:provider/provider.dart';

class ServicesPricing extends StatefulWidget {
  const ServicesPricing({super.key});

  @override
  State<ServicesPricing> createState() => _ServicesPricingState();
}

class _ServicesPricingState extends State<ServicesPricing> {
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
      padding: EdgeInsets.all(ResponsiveWidget.isSmallScreen(context)
          ? AppColorConstant.defaultPadding / 2
          : AppColorConstant.defaultPadding),
      decoration: const BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Consumer<ServicesProvider>(
        builder: (context, servicesProvider, child) {
          final services = servicesProvider.services;
          if (servicesProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Services",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap:
                      true, // Use this to make ListView occupy only the space it needs
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://makeup-star-studio.sfo2.digitaloceanspaces.com/services/${service.image}',
                            ),
                            radius: 25,
                            backgroundColor: Colors.grey[200],
                            child: service.image!.isEmpty
                                ? const Icon(Icons.image, size: 25)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(service.price.toString()),
                                Text(service.category),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
