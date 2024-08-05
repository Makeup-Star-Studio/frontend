import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/model/booking_model.dart';

class BookingInfoCard extends StatelessWidget {
  final Booking bookingInfo;

  const BookingInfoCard({
    super.key,
    required this.bookingInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppColorConstant.defaultPadding),
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding / 2),
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color: AppColorConstant.adminPrimaryColor.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppColorConstant.defaultPadding),
        ),
      ),
      child: Stack(
        children: [
          ListTile(
            leading: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColorConstant.adminPrimaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Icon(
                Icons.person,
                color: AppColorConstant.adminPrimaryColor,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bookingInfo.fname,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  bookingInfo.serviceType.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black54),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //hh:mm am/pm
                  'Arrival: ${DateFormat.jm().format(bookingInfo.eventDate.toLocal())}',
                  // 'Arrival: ${bookingInfo.eventDate.toLocal().hour}:${bookingInfo.eventDate.toLocal().minute} ${bookingInfo.eventDate.toLocal().hour > 12 ? 'PM' : 'AM'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$${bookingInfo.servicePricing}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black54),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AdminPage(selectedIndex: 1);
                }));
              },
              icon: const Icon(Icons.more_vert),
            ),
          ),
        ],
      ),
    );
  }
}
