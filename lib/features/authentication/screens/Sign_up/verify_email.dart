import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/success_screen/success_screen.dart';
import 'package:project_bc_tuto/features/authentication/screens/login/login.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers.onboarding/sign_up/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(VerificationController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const CandidateLoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                  image: const AssetImage(JImages.deliveredEmailIllustration),
                  width: JHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Tittle and subtitle
              Text(JTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwItems),

              Text(email ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwItems),

              Text(JTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => SuccessScreen(
                        image: JImages.staticSuccessIllustration,
                        title: JTexts.yourAccountCreatedTitle,
                        subTitle: JTexts.yourAccountCreatedSubTitle,
                        onPressed: () => Get.to(() => const CandidateLoginScreen()),
                      )),
                      child: const Text(JTexts.jContinue))),
              const SizedBox(height: JSizes.spaceBtwItems),

              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {}, child: const Text(JTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
