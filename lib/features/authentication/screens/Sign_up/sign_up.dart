import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/login_setup/Form_Divider.dart';
import 'package:project_bc_tuto/common/widgets/login_setup/social_buttons.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class CadidateSignupScreen extends StatelessWidget {
  const CadidateSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(JTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Form
              const JSignupStep1Form(),

              const SizedBox(height: JSizes.spaceBtwSections),

              ///Divider
              TFormDivider(dividerText: JTexts.orSignUpWith.capitalize!),

              const SizedBox(height: JSizes.spaceBtwSections),

              ///Social buttons
              const TSocialButtons(),

            ],

          ),
        ),
      ),
    );
  }
}


