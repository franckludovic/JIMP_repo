

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:project_bc_tuto/features/authentication/screens/login/widgets/login_form.dart';
import 'package:project_bc_tuto/features/authentication/screens/login/widgets/login_header.dart';


import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/login_setup/Form_Divider.dart';
import '../../../../common/widgets/login_setup/social_buttons.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../Sign_up/step1_sign_up.dart';

class CandidateLoginScreen extends StatelessWidget {
  const CandidateLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom:  JSizes.defaultSpace, left: JSizes.defaultSpace, right: JSizes.defaultSpace, top: 0),
          child: Column(
            children: [
              ///login title and subtitle
              const JLoginHeader(),

                ///form
              JLoginForm(onPressed: () => Get.to(() => const CandidateRegisterScreen1()),),

            ],
          ),
        ),
      ),
    );
  }
}







