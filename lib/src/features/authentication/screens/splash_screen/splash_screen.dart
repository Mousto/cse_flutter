import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cse_talant_valmy/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:cse_talant_valmy/src/common_widgets/fade_in_animation_controller.dart';
import 'package:cse_talant_valmy/src/constants/colors.dart';
import 'package:cse_talant_valmy/src/constants/text_strings.dart';
import 'package:cse_talant_valmy/src/constants/sizes.dart';
import 'package:cse_talant_valmy/src/constants/image_string.dart';

import '../../../../common_widgets/fade_in_animation/animation_design.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            anime: TAnimatedPosition(
                topAfter: 0, topBefore: -30, leftBefore: -30, leftAfter: 0),
            child: const Image(image: AssetImage(tSplashTopIcon)),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            anime: TAnimatedPosition(
                topBefore: 80,
                topAfter: 80,
                leftAfter: tDefaultSize,
                leftBefore: -80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tAppName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  tAppTagLine,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            anime: TAnimatedPosition(bottomBefore: 0, bottomAfter: 100),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 1,
              child: const Image(
                image: AssetImage(tSplashImage),
              ),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            anime: TAnimatedPosition(
                bottomBefore: 0,
                bottomAfter: 60,
                rightBefore: tDefaultSize,
                rightAfter: tDefaultSize),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
