import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import '../../constants/image_string.dart';
import '../fade_in_animation_controller.dart';
import 'fade_in_animation_model.dart';

class TFadeInAnimation extends StatelessWidget {
  TFadeInAnimation({
    super.key,
    required this.durationInMs,
    required this.child,
    this.anime,
  });

  final controller = Get.put(FadeInAnimationController());
  final int durationInMs;
  final TAnimatedPosition? anime;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      //On définit l'observateur
      () => AnimatedPositioned(
        duration: Duration(milliseconds: durationInMs),
        top: controller.animate.value ? anime!.topAfter : anime!.topBefore,
        left: controller.animate.value ? anime!.leftAfter : anime!.leftBefore,
        bottom:
            controller.animate.value ? anime!.bottomAfter : anime!.bottomBefore,
        right:
            controller.animate.value ? anime!.rightAfter : anime!.rightBefore,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: durationInMs),
          opacity: controller.animate.value ? 1 : 0,
          child: child,
          // const Image(
          //   image: AssetImage(tSplashTopIcon),
          // ),
        ),
      ),
    );
  }
}
