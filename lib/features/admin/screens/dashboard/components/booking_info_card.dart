import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/features/admin/models/upcoming_bookings.dart';

class BookingInfoCard extends StatelessWidget {
  const BookingInfoCard({
    super.key,
    required this.bookingInfo,
  });

  final BookingsInfoModel bookingInfo;

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
            // isThreeLine: true,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align to the start
              children: [
                Text(
                  bookingInfo.clientName!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  bookingInfo.serviceType!,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black54),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Arrival - ${DateFormat('HH:mm').format(bookingInfo.date!)}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black54),
                ),
                Text(
                  bookingInfo.price!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // trailing: const Icon(Icons.more_horiz, color: Colors.black),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                // _showCalendarPicker(context);
              },
              icon: const Icon(Icons.more_horiz),
            ),
          )
        ],
      ),
    );
  }
}

// Row(
//         children: [
//           SizedBox(
//             height: 20,
//             width: 20,
//             child: SvgPicture.asset(svgSrc),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: AppColorConstant.defaultPadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     "$numOfFiles Files",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall!
//                         .copyWith(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Text(amountOfFiles)
//         ],
//       ),