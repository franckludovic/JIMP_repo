import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/authentication/screens/login/login.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers.onboarding/forgot_password/forgot_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///image

              Image(
                  image: AssetImage(JImages.deliveredEmailIllustration),
                  width: JHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Email, Tittle and subtitle
              Text(email,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwItems),

              Text(JTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwItems),

              Text(JTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(() => const  CandidateLoginScreen()), child: const Text(JTexts.done))),
              const SizedBox(height: JSizes.spaceBtwItems),

              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => ForgotPasswordController.instance.resendPasswordRestEmail(email), child: const Text(JTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
