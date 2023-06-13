import 'package:get/get.dart';

import '../features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs; //Devient observable

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true; //animate.value car la variable est de type RxBool
    await Future.delayed(const Duration(milliseconds: 3500));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));

    // Get.to(() =>
    //     const SignUpScreen()); //pas besoin de context avec Getx pour la navigation
    // Get.to(() =>
    //     const LoginScreen()); //pas besoin de context avec Getx pour la navigation

    // Get.to(() => const WelcomeScreen(),
    //     duration:
    //         const Duration(seconds: 1), //duration of transitions, default 1 sec
    //     transition: Transition.noTransition //transition effect
    //     ); //pas besoin de context avec Getx pour la navigation

    // Get.to(() =>
    //     OnBoardingScreen()); //pas besoin de context avec Getx pour la navigation
    Get.to(() =>
        const OTPScreen()); //pas besoin de context avec Getx pour la navigation
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true; //animate.value car la variable est de type
  }
}
