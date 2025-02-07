import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/onboarding_controllers.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';

import '../widgets/onboarding_dot_navigation.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_skip.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return  Scaffold(
      body: Stack(
        children: [
          ///horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  [
              OnBoardingPage(
                  image: JImages.onBoardingImages1,
                  title: JTexts.onBoardingTitle1,
                  subtitle: JTexts.onBoardingSubTitle1
              ),
              OnBoardingPage(
                  image: JImages.onBoardingImages2,
                  title: JTexts.onBoardingTitle2,
                  subtitle: JTexts.onBoardingSubTitle2
              ),
              OnBoardingPage(
                  image: JImages.onBoardingImages3,
                  title: JTexts.onBoardingTitle3,
                  subtitle: JTexts.onBoardingSubTitle3
              ),
            ],
          ),

          ///Skip button
          const OnboardingSkip(),

          ///Dot navigation smoothpageIdicator
          const OnboardingDotNavigation(),

          ///circular button
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}








