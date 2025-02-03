import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/login_setup/Form_Divider.dart';
import 'package:project_bc_tuto/common/widgets/login_setup/social_buttons.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Form
              const TSignupForm(),

              const SizedBox(height: TSizes.spaceBtwSections),

              ///Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwSections),

              ///Social buttons
              const TSocialButtons(),

            ],

          ),
        ),
      ),
    );
  }
}


