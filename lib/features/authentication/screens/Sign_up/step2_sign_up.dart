import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import 'package:project_bc_tuto/common/widgets/sign_upButtons/signUpNavButtons.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step3_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_wigets/custom_dropDown.dart';
import '../../../../common/widgets/custom_wigets/custom_textfield.dart';
import '../../../../common/widgets/documents_cad/additonal_file_checkbox_picker.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../utils/device/device_utility.dart';


class CandidateRegisterScreen2 extends StatefulWidget {
  const CandidateRegisterScreen2({super.key});

  @override
  State<CandidateRegisterScreen2> createState() => _CandidateRegisterScreen2State();
}

class _CandidateRegisterScreen2State extends State<CandidateRegisterScreen2> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: JAppbar(title: Text(
        "Profile Information Screen",
        style: Theme
            .of(context)
            .textTheme
            .headlineMedium,
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Username Field
                        const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: JSizes.md),


                        // Profile Image Upload Button

                        DocumentUploadWidget(),

                        AdditionalFilesWidget(),


                        const SizedBox(height: JSizes.md),

                        // Dropdowns
                        Row(
                          children: [
                            Expanded(child: buildDropdown("Country")),
                            const SizedBox(width: JSizes.md),
                            Expanded(child: buildDropdown("Region")),

                          ],
                        ),

                        const SizedBox(height: JSizes.spaceBtwItems * 1.5),

                        Row(
                          children: [
                            Expanded(child: buildDropdown("City")),
                            const SizedBox(width: JSizes.md),
                            Expanded(child: buildTextField("Local address")),
                          ],
                        ),
                        const SizedBox(height: JSizes.spaceBtwItems * 2),

                        buildDropdown("Education Level"),
                        const SizedBox(height: JSizes.spaceBtwItems * 2),

                        buildDropdown("School last attended"),
                        const SizedBox(height: JSizes.spaceBtwItems * 2),



                        JDivider(),
                        // Bottom Step Indicator
                      ],
                    ),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SignUpNavigationButtons(onPressed:() => Get.to(() => CandidateRegisterScreen3()) ),

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
      ),
    );
  }

}

