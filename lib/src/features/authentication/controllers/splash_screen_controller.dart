import 'package:get/get.dart';

import 'package:cse_talant_valmy/src/features/authentication/screens/welcome/welcome_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs; //Devient observable

  Future startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    print('Début aniamation');

    animate.value = true; //animate.value car la variable est de type RxBool
    await Future.delayed(Duration(milliseconds: 5000));
    print('Changement écran');

    Get.to(() =>
        WelcomeScreen()); //pas besoin de context avec Getx pour la navigation
  }
}
