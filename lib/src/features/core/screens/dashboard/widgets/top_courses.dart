import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class TopCourses extends StatelessWidget {
  const TopCourses({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tDashboardTopCourses,
          style: txtTheme.titleLarge
              ?.apply(color: Colors.black, fontSizeFactor: 1.2),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 320,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tCardBgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Flutter crash course",
                                  style: txtTheme.titleMedium
                                      ?.apply(color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Flexible(
                                child: Image(
                                  image: AssetImage(tTopCourseImage1),
                                  height: 110,
                                  width: 110,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.black),
                              onPressed: () {},
                              child: const Icon(Icons.play_arrow),
                            ),
                            const SizedBox(width: tDashboardCardPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3 Sections",
                                  style: txtTheme.titleSmall?.apply(
                                      color: Colors.black, fontSizeFactor: 1.2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Langage de programation",
                                  style: txtTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5),
                child: SizedBox(
                  width: 320,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tCardBgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Flutter crash course",
                                  style: txtTheme.titleMedium
                                      ?.apply(color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Flexible(
                                child: Image(
                                  image: AssetImage(tTopCourseImage1),
                                  height: 110,
                                  width: 110,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.black),
                              onPressed: () {},
                              child: const Icon(Icons.play_arrow),
                            ),
                            const SizedBox(width: tDashboardCardPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3 Sections",
                                  style: txtTheme.titleSmall?.apply(
                                      color: Colors.black, fontSizeFactor: 1.2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Langage de programation",
                                  style: txtTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: SizedBox(
                  width: 320,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tCardBgColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Flutter crash course",
                                  style: txtTheme.titleMedium
                                      ?.apply(color: Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Flexible(
                                child: Image(
                                  image: AssetImage(tTopCourseImage1),
                                  height: 110,
                                  width: 110,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.black),
                              onPressed: () {},
                              child: const Icon(Icons.play_arrow),
                            ),
                            const SizedBox(width: tDashboardCardPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3 Sections",
                                  style: txtTheme.titleSmall?.apply(
                                      color: Colors.black, fontSizeFactor: 1.2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Langage de programation",
                                  style: txtTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
