

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_bc_tuto/features/authentication/screens/login/widgets/login_form.dart';
import 'package:project_bc_tuto/features/authentication/screens/login/widgets/login_header.dart';


import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_setup/Form_Divider.dart';
import '../../../../common/widgets/login_setup/social_buttons.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///login title and subtitle
              const TLoginHeader(),

                ///form
              const TLoginForm(),

              ///divider
              TFormDivider(dividerText: JTexts.orSignInWith.capitalize!),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///footer 
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}







