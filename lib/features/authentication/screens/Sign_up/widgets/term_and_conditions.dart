import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers.onboarding/sign_up/sign_up_controller.dart';

class TermandConditions extends StatelessWidget {
  const TermandConditions({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());

    return Row(
      children: [
        SizedBox(width: 24, height: 24, child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
        const SizedBox(width: JSizes.spaceBtwItems),
        Text.rich(
            TextSpan(children: [
              TextSpan(text: JTexts.iAgreeTo, style: Theme.of(context).textTheme.bodySmall),

              TextSpan(text: ' ${JTexts.privacyPolicy}', style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? JColors.white : JColors.primary,
                decoration: TextDecoration.underline,
                decorationColor:  dark ? JColors.white : JColors.primary,
              ) ),

              TextSpan(text: ' ${JTexts.and} ', style: Theme.of(context).textTheme.bodySmall),

              TextSpan(text: JTexts.termsOfUse, style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? JColors.white : JColors.primary,
                decoration: TextDecoration.underline,
                decorationColor:  dark ? JColors.white : JColors.primary,
              ) ),
            ]
            )
        )
      ],
    );
  }
}