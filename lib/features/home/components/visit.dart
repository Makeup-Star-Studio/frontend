// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/src/provider/visitCount/visit_count_provider.dart';
// import 'package:provider/provider.dart';

// class VisitCounterScreen extends StatefulWidget {
//   const VisitCounterScreen({super.key});

//   @override
//   _VisitCounterScreenState createState() => _VisitCounterScreenState();
// }

// class _VisitCounterScreenState extends State<VisitCounterScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final visitProvider = Provider.of<VisitProvider>(context, listen: false);
//     visitProvider.fetchVisitCount().then((_) {
//       visitProvider.increaseVisitCount();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Consumer<VisitProvider>(
//         builder: (context, visitProvider, child) {
//           return Text(
//             'Number of visits: ${visitProvider.count}',
//             style: const TextStyle(fontSize: 24),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/src/provider/visitCount/visit_count_provider.dart';
import 'package:provider/provider.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});
  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  @override
  void initState() {
    super.initState();
    final visitProvider = Provider.of<VisitProvider>(context, listen: false);
    visitProvider.fetchVisitCount().then((_) {
      visitProvider.increaseVisitCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitProvider>(builder: (context, visitProvider, child) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatCard(
              context,
              '10+ Years of Experience',
              Icons.access_time,
            ),
            _buildStatCard(
              context,
              '500+ Satisfied Clients',
              Icons.star,
            ),
            _buildStatCard(
              context,
              count: visitProvider.count,
              'Number of Visits',
              Icons.visibility,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard(
    BuildContext context,
    String text,
    IconData icon, {
    int? count,
  }) {
    return Card(
      elevation: 4, // Light box shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      color: AppColorConstant.buttonColor,
      child: SizedBox(
        width: 300,
        height: 300, // Adjust height as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 30,
                color: AppColorConstant.subHeadingColor.withOpacity(0.5)),
            const SizedBox(height: 8),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (count != null)
              Text(count.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
