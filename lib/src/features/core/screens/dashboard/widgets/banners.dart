import 'package:flutter/material.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/image_string.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class Banners extends StatelessWidget {
  const Banners({
    super.key,
    required this.txtTheme,
  });

  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                      style: txtTheme.bodySmall?.apply(color: Colors.black),
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
