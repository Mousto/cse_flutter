import 'package:flutter/material.dart';

import 'package:cse_talant_valmy/src/constants/sizes.dart';
import 'package:cse_talant_valmy/src/features/authentication/model/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    super.key,
    required this.onBoardingModel,
  });

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(tDefaultSize),
      color: onBoardingModel.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Image(
              image: AssetImage(
                onBoardingModel.image,
              ),
              height: screenSize.height * 0.4,
            ),
          ),
          Column(
            children: [
              Text(
                onBoardingModel.title, //tOnboardingTitle1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                onBoardingModel.subtitle, //tOnboardingSubtitle1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            onBoardingModel.counterText, //tOnboardingCounter1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
