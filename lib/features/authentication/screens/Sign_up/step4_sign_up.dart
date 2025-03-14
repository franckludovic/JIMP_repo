import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step5_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../common/widgets/link_input_fields/linkInputFields.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../common/widgets/texts/textArea.dart';
import '../../../../utils/device/device_utility.dart';



class CandidateRegisterScreen4 extends StatefulWidget {
  const CandidateRegisterScreen4({super.key});

  @override
  State<CandidateRegisterScreen4> createState() => _CandidateRegisterScreen4State();
}

class _CandidateRegisterScreen4State extends State<CandidateRegisterScreen4> {
  int currentStep = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: JAppbar(title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Resume info", style: Theme.of(context).textTheme.headlineMedium,
          ),

          ElevatedButton(
            onPressed: () {
              // Skip action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: JColors.primary,
              padding: EdgeInsets.symmetric(
                  horizontal: JSizes.md, vertical: JSizes.sm),
            ),
            child: Text("Skip",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Description TextField
                  JTextArea(hintText: "Brief Description just to know you and your career objectives and dream", label: Text("Self Description"),),
                  const SizedBox(height: JSizes.spaceBtwSections),


                  // Upload Resume
                  DocumentUploadWidget(title: "Upload Resume",),

                  const SizedBox(height: JSizes.spaceBtwItems),

                  DocumentUploadWidget(title: "Upload Cover letter",),

                  const SizedBox(height: JSizes.spaceBtwSections),

                  // Linked Accounts
                  LinkInputWidget(title: "LinkedIn", defaultUrl: "https://linkedin.com/in/yourprofile"),

                  const SizedBox(height: JSizes.spaceBtwItems),

                  LinkInputWidget(title: "GitHub", defaultUrl: "https://github.com/yourusername"),

                  const SizedBox(height: JSizes.spaceBtwItems),

                  LinkInputWidget(title: "Portfolio", defaultUrl: "https://yourportfolio.com"),

                  const SizedBox(height: JSizes.spaceBtwSections),

                  JDivider(),

                ],
              ),
            ),
          ],
        ),
      ),

      // Step Indicator
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SignUpNavigationButtons(onPressed:() => Get.to(() => CandidateRegisterScreen5()) ),

          Padding(
            padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
            child: Positioned(
                bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                left: 0,
                right: 0,
                child: StepIndicator(currentIndex: currentStep, totalSteps: 5)
            ),
          ),
        ],
      ),
    );
  }


}

