import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../../constants/colors.dart';
import '../../../constants/image_string.dart';
import '../../../constants/text_strings.dart';
import '../model/model_on_boarding.dart';
import '../screens/on_boarding/on_boarding_page_widget.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs; // Observation des variation de currentPage

  //Les pages
  final pages = [
    OnBoardingPageWidget(
      onBoardingModel: OnBoardingModel(
        image: tOnBordingImage1,
        title: tOnboardingTitle1,
        subtitle: tOnboardingSubtitle1,
        counterText: tOnboardingCounter1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      onBoardingModel: OnBoardingModel(
        image: tOnBordingImage2,
        title: tOnboardingTitle2,
        subtitle: tOnboardingSubtitle2,
        counterText: tOnboardingCounter2,
        bgColor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      onBoardingModel: OnBoardingModel(
        image: tOnBordingImage3,
        title: tOnboardingTitle3,
        subtitle: tOnboardingSubtitle3,
        counterText: tOnboardingCounter3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];

  // Au changement de page
  void changementDePageCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  //Saut à la dernière page
  skip() => controller.jumpToPage(page: 2);

  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
