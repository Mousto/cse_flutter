import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common_widgets/fade_in_animation/fade_in_animation_model.dart';
import '../../../../common_widgets/fade_in_animation_controller.dart';
import '../../../../common_widgets/fade_in_animation/animation_design.dart';
//import 'package:cse_talant_valmy/screens/tabs_screen.dart';
//import 'package:cse_talant_valmy/screens/signup_screen.dart';
//import '../../../../../screens/signup_screen.dart';
import '../../../../constants/colors.dart';
import '../login/login_screen.dart';
import '../../../../constants/text_strings.dart';
import '../../../../constants/image_string.dart';
import '../signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();

    var mediaquery = MediaQuery.of(context);
    var screenHeight = mediaquery.size.height;
    var brightness = mediaquery.platformBrightness;
    final isDarkmode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkmode ? tSecondaryColor : tLindaWelcomeScreenBgColor,
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1200,
            anime: TAnimatedPosition(
              bottomAfter: 0,
              bottomBefore: -100,
              leftAfter: 10,
              leftBefore: 0,
              rightAfter: 10,
              rightBefore: 0,
              topAfter: 0,
              topBefore: 0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(
                  image: const AssetImage(tWelcomeStringImage),
                  height: screenHeight * 0.5,
                ),
                Column(
                  children: [
                    Text(
                      tWelcomeTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      tWelcomeSubtitle,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(
                          () => const LoginScreen(),
                        ), // Utiliation de GetX pour la rédirection.
                        child: Text(
                          tLogin.toLowerCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const SignUpScreen()),
                        child: Text(
                          tSignup.toUpperCase(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    /*return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(TabsScreen.routeName);
          },
          child: const Text('Vers les produits'),
        ),
      ),
    );*/
  }
}
