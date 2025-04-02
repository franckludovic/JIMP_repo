
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/login/widgets/login_form.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/login/widgets/login_header.dart';



import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/login_setup/Form_Divider.dart';
import '../../../../common/widgets/login_setup/social_buttons.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../screens/login/widgets/login_form.dart';
import '../sign_up/sign_up1.dart';

class CompagnyLoginScreen extends StatelessWidget {
  const CompagnyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom:  JSizes.defaultSpace, left: JSizes.defaultSpace, right: JSizes.defaultSpace, top: 0),
          child: Column(
            children: [
              ///login title and subtitle
              const JLoginHeader2(),

                ///form
              JLoginForm(onPressed: () => Get.to(() => CompanySignUpScreen1()),),


            ],
          ),
        ),
      ),
    );
  }
}







