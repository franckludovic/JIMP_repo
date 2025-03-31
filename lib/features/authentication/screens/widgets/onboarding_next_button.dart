import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers.onboarding/onboarding_controllers/onboarding_controllers.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return Positioned(
      right: JSizes.defaultSpace,
      bottom: JDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnboardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: CircleBorder(), backgroundColor: dark ? JColors.primary : Colors.black),
        child: Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}