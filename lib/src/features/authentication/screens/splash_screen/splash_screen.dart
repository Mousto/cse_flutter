import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cse_talant_valmy/src/features/authentication/controllers/splash_screen_controller.dart';
// import 'package:cse_talant_valmy/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:cse_talant_valmy/src/constants/colors.dart';
import 'package:cse_talant_valmy/src/constants/text_strings.dart';
import 'package:cse_talant_valmy/src/constants/sizes.dart';
import 'package:cse_talant_valmy/src/constants/image_string.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final splachController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splachController.startAnimation();
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            //On définit l'observateur
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: splachController.animate.value ? 0 : -30,
              left: splachController.animate.value ? 0 : -30,
              child: Image(image: AssetImage(tSplashTopIcon)),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1600),
              top: 80,
              left: splachController.animate.value ? tDefaultSize : -80,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1600),
                opacity: splachController.animate.value ? 1 : 0,
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
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splachController.animate.value ? 100 : 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splachController.animate.value ? 1 : 0,
                child: Image(
                  image: ResizeImage(
                    AssetImage(tSplashImage),
                    width: 350,
                    height: 400,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 2400),
              bottom: splachController.animate.value ? 60 : 0,
              right: tDefaultSize,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 2000),
                opacity: splachController.animate.value ? 1 : 0,
                child: Container(
                  width: tSplashContainerSize,
                  height: tSplashContainerSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
