import 'package:cse_talant_valmy/src/features/core/models/dashboard/categories_model.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    final list = DashboardCategories.list;
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true, //permet de ne charger que les éléments visibles.
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 170,
            height: 45,
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tDarkColor,
                  ),
                  child: Center(
                    child: Text(list[index].title,
                        style: txtTheme.titleSmall?.apply(color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  //Flexible pour permettre de rajouter la propiété overflow aux textes du Column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list[index].heading,
                        style: txtTheme.titleMedium?.apply(
                          color: Colors.black,
                        ),
                        overflow: TextOverflow
                            .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
                      ),
                      Text(
                        list[index].subHeading,
                        style: txtTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // children: [
        //   SizedBox(
        //     width: 170,
        //     height: 45,
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 45,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: tDarkColor,
        //           ),
        //           child: Center(
        //             child: Text('JS',
        //                 style: txtTheme.titleSmall?.apply(color: Colors.white)),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5.0,
        //         ),
        //         Flexible(
        //           //Flexible pour permettre de rajouter la propiété overflow aux textes du Column
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 'Javascript',
        //                 style: txtTheme.titleMedium?.apply(
        //                   color: Colors.black,
        //                 ),
        //                 overflow: TextOverflow
        //                     .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
        //               ),
        //               Text(
        //                 '10 Lessons',
        //                 style: txtTheme.bodyMedium,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   SizedBox(
        //     width: 170,
        //     height: 45,
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 45,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: tDarkColor,
        //           ),
        //           child: Center(
        //             child: Text('JS',
        //                 style: txtTheme.titleSmall?.apply(color: Colors.white)),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5.0,
        //         ),
        //         Flexible(
        //           //Flexible pour permettre de rajouter la propiété overflow aux textes du Column
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 'Javascript',
        //                 style: txtTheme.titleMedium?.apply(
        //                   color: Colors.black,
        //                 ),
        //                 overflow: TextOverflow
        //                     .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
        //               ),
        //               Text(
        //                 '10 Lessons',
        //                 style: txtTheme.bodyMedium,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   SizedBox(
        //     width: 170,
        //     height: 45,
        //     child: Row(
        //       children: [
        //         Container(
        //           width: 45,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: tDarkColor,
        //           ),
        //           child: Center(
        //             child: Text('JS',
        //                 style: txtTheme.titleSmall?.apply(color: Colors.white)),
        //           ),
        //         ),
        //         const SizedBox(
        //           width: 5.0,
        //         ),
        //         Flexible(
        //           //Flexible pour permettre de rajouter la propiété overflow aux textes du Column
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Text(
        //                 'Javascript',
        //                 style: txtTheme.titleMedium?.apply(
        //                   color: Colors.black,
        //                 ),
        //                 overflow: TextOverflow
        //                     .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
        //               ),
        //               Text(
        //                 '10 Lessons',
        //                 style: txtTheme.bodyMedium,
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
