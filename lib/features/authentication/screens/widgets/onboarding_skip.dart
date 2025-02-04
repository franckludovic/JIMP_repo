import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/onboarding_controllers.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';


class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: JSizes.defaultSpace,
        child: TextButton(onPressed: () => OnboardingController.instance.skipPage(), child:  const Text('Skip'))
    );
  }
}

