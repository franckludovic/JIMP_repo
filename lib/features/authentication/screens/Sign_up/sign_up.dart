import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step2_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../compamy_screens/sign_up/widget/step_indicator.dart';


class CadidateSignupScreen extends StatefulWidget {
  const CadidateSignupScreen({super.key});

  @override
  State<CadidateSignupScreen> createState() => _CandidateRegisterScreenState();
}

class _CandidateRegisterScreenState extends State<CadidateSignupScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar( showBackArrow: true ,title: Text(JTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Form
              const JSignupStep1Form(),

              const SizedBox(height: JSizes.spaceBtwSections),

              ///Divider
             // TFormDivider(dividerText: JTexts.orSignUpWith.capitalize!),

              const SizedBox(height: JSizes.spaceBtwSections),

              ///Social buttons
              //const TSocialButtons(),

            ],

          ),
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: JSizes.lg ),
            child: ElevatedButton(onPressed: () => Get.to(() => const CandidateRegisterScreen2() ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: JSizes.sm, horizontal: JSizes.lg)
                ),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(JTexts.MoveToNext, style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                    SizedBox(width: JSizes.lg,),
                    Icon(Iconsax.arrow_right_2, size: 50,)
                  ],
                )
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
            child: Positioned(
                bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                left: 0,
                right: 0,
                child: StepIndicator(currentIndex: currentStep, totalSteps: 4)
            ),
          ),
        ],
      ),
    );
  }
}


