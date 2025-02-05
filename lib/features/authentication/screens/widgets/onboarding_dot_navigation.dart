import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/onboarding_controllers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnboardingController.instance;
    final dark = JHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: JDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: JSizes.defaultSpace,

      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(activeDotColor: dark ? JColors.light:  JColors.dark, dotHeight: 6),

      ),

    );
  }
}