import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../compamy_screens/sign_up/widget/step_indicator.dart';


class CompanySignupScreen extends StatefulWidget {
  const CompanySignupScreen({super.key});

  @override
  State<CompanySignupScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends State<CompanySignupScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title:  Text(JTexts.signupTitle,
          style: Theme.of(context).textTheme.headlineMedium),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///Form
              const JSignUpCompanypage1(),

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

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
        child: Positioned(
            bottom: JDeviceUtils.getBottomNavigationBarHeight(),
            left: 0,
            right: 0,
            child: StepIndicator(currentIndex: currentStep, totalSteps: 4)
        ),
      ),
    );
  }
}


