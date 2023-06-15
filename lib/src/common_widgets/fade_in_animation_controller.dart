import 'package:get/get.dart';

import '../features/authentication/screens/welcome/welcome_screen.dart';
import '../features/core/screens/dashboard/widgets/dashboard.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs; //Devient observable

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true; //animate.value car la variable est de type RxBool
    await Future.delayed(const Duration(milliseconds: 3500));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));

    // Get.to(() => const WelcomeScreen(),
    //     transition: Transition.noTransition //transition effect
    //     ); //pas besoin de context avec Getx pour la navigation

    Get.to(
      () => const Dashboard(),
    ); //pas besoin de context avec Getx pour la navigation
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true; //animate.value car la variable est de type
  }
}
