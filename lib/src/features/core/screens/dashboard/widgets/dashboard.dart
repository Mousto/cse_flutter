import 'package:cse_talant_valmy/src/constants/colors.dart';
import 'package:cse_talant_valmy/src/constants/image_string.dart';
import 'package:cse_talant_valmy/src/constants/text_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../constants/sizes.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //Variables
    final txtTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          title: Text(
            tAppName,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tCardBgColor,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage(tUserProfileImage),
                  height: 20,
                ),
              ),
            ),
          ],
        ),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(width: 4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tDashboardSearch,
                        style: txtTheme.headlineSmall?.apply(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      const Icon(Icons.mic, size: 25),
                    ],
                  ),
                ),
                const SizedBox(
                  height: tDashboardPadding,
                ),

                //Catégories
                SizedBox(
                  height: 45,
                  child: ListView(
                    shrinkWrap:
                        true, //permet de ne charger que les éléments visibles.
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
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
                                child: Text('JS',
                                    style: txtTheme.titleSmall
                                        ?.apply(color: Colors.white)),
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
                                    'Javascript',
                                    style: txtTheme.titleMedium?.apply(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
                                  ),
                                  Text(
                                    '10 Lessons',
                                    style: txtTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
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
                                child: Text('JS',
                                    style: txtTheme.titleSmall
                                        ?.apply(color: Colors.white)),
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
                                    'Javascript',
                                    style: txtTheme.titleMedium?.apply(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
                                  ),
                                  Text(
                                    '10 Lessons',
                                    style: txtTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
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
                                child: Text('JS',
                                    style: txtTheme.titleSmall
                                        ?.apply(color: Colors.white)),
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
                                    'Javascript',
                                    style: txtTheme.titleMedium?.apply(
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow
                                        .ellipsis, //Permet de rajouter des pointillets à la fin des textes longs pour eviter de faire crasher l'app.
                                  ),
                                  Text(
                                    '10 Lessons',
                                    style: txtTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: tDashboardPadding,
                ),
                //BANNER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tCardBgColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Image(
                                    image: AssetImage(tBookmarkIcon),
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Flexible(
                                  child: Image(
                                    image: AssetImage(tBannerImage2),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Text(
                              tDashboardBannerTitle1,
                              style: txtTheme.titleMedium?.apply(
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              tDashboardBannerSubTitle,
                              style: txtTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: tDashboardCardPadding,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tCardBgColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Image(
                                        image: AssetImage(tBookmarkIcon),
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    Flexible(
                                      child: Image(
                                        image: AssetImage(tBannerImage2),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  tDashboardBannerTitle2,
                                  style: txtTheme.titleMedium?.apply(
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  tDashboardBannerSubTitle,
                                  style: txtTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed: () {},
                                child: Text(
                                  tDashboardButton,
                                  style: txtTheme.bodySmall
                                      ?.apply(color: Colors.black),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
