import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/on_boarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onBoardingController = OnBoardingController();
    final hauteurEcran = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: onBoardingController.pages,
            liquidController: onBoardingController.controller,
            onPageChangeCallback: onBoardingController.changementDePageCallback,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: hauteurEcran * 0.04,
            child: OutlinedButton(
              onPressed: () {
                onBoardingController.animateToNextSlide();
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20.0),
                foregroundColor: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Color(0xff272727),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Positioned(
            top: hauteurEcran * 0.1,
            left: hauteurEcran * 0.4,
            child: TextButton(
              onPressed: () => onBoardingController.skip(),
              child: const Text(
                'Skip',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: hauteurEcran * 0.01,
              child: AnimatedSmoothIndicator(
                activeIndex: onBoardingController.currentPage.value,
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: (5.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
