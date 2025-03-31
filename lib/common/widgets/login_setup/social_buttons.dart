import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/login/login_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';


class JSocialButtons extends StatelessWidget {
  const JSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: JColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleSignIn,
            icon: const Image(
              width: JSizes.iconMd,
              height: JSizes.iconMd,
              image: AssetImage(JImages.google),
            ),

          ),
        ),
        const SizedBox(width: JSizes.spaceBtwItems),

        Container(
          decoration: BoxDecoration(border: Border.all(color: JColors.grey), borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: JSizes.iconMd,
              height: JSizes.iconMd,
              image: AssetImage(JImages.facebook),
            ),

          ),
        ),
      ],
    );
  }
}