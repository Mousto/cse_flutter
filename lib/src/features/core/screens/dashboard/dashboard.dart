import 'package:flutter/material.dart';

import '../../../../../widgets/main_drawer.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import 'widgets/Categories.dart';
import 'widgets/appbar.dart';
import 'widgets/banners.dart';
import 'widgets/search.dart';
import 'widgets/top_courses.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //Variables
    final txtTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: const DashboardAppbar(),
        drawer: const MainDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //HEADING
                Text(
                  tDashboardTitle,
                  style: txtTheme.bodyMedium,
                ),
                Text(
                  tDashboardHeading,
                  style: txtTheme.headlineSmall,
                ),
                const SizedBox(height: tDashboardPadding),

                //SEARCH BOX
                Search(txtTheme: txtTheme),
                const SizedBox(
                  height: tDashboardPadding,
                ),

                //Catégories
                Categories(txtTheme: txtTheme),
                const SizedBox(
                  height: tDashboardPadding,
                ),
                //BANNER
                Banners(txtTheme: txtTheme),
                const SizedBox(
                  height: tDashboardPadding,
                ),

                //TOP COURSES
                TopCourses(txtTheme: txtTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
