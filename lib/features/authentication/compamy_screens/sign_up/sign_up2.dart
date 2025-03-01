import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/documents_cad/file_picker_card.dart';
import 'package:project_bc_tuto/common/widgets/texts/textArea.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/add_recruiter.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up3.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../compamy_screens/sign_up/widget/step_indicator.dart';

class CompanySignupScreen2 extends StatefulWidget {
  const CompanySignupScreen2({super.key});

  @override
  State<CompanySignupScreen2> createState() => _CompanyRegisterScreenState2();
}

class _CompanyRegisterScreenState2 extends State<CompanySignupScreen2> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Company Profile Setup",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JTextArea(
                  label: Text('Company Name'),
                  maxAreaHeight: 1,
                  minAreaHeight: 1,
                  prefixIcon: Icon(
                    Iconsax.buildings,
                  )),
              SizedBox(
                height: JSizes.spaceBtwSections * 0.8,
              ),
              JTextArea(
                  label: Text('Company location'),
                  maxAreaHeight: 1,
                  minAreaHeight: 1,
                  prefixIcon: Icon(
                    Iconsax.location,
                  )),
              SizedBox(
                height: JSizes.spaceBtwSections * 0.8,
              ),
              JTextArea(
                label: Text("Company Description"),
                hintText: "Describe what you company is about",
              ),
              SizedBox(
                height: JSizes.spaceBtwSections * 0.8,
              ),
              Row(
                children: [
                  Expanded(
                      child: DocumentUploadWidget(
                    title: 'Logo',
                    documentType: 'PNG, JPG',
                  )),
                  SizedBox(
                    width: JSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                      child: DocumentUploadWidget(
                    title: 'Profile image',
                    documentType: 'PNG, JPG',
                  )),
                ],
              ),


              SizedBox(
                child: TextButton(
                  onPressed: () => Get.to(() => const AddRecruiterForm()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      // Icon with vertical adjustment (optional)
                      Transform.translate(
                        offset: Offset(0, 4), // Adjust vertically to align with text baseline
                        child: Icon(Iconsax.user_add, size: 30),
                      ),
                      SizedBox(width: JSizes.sm),
                      Text(
                        "Add a Recruiter to your profile",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: JSizes.spaceBtwSections * 0.8,
              ),
              SizedBox(height: JSizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SignUpNavigationButtons(
              onPressed: () => Get.to(() => CompanySignupScreen3()),
            ),
            SizedBox(height: JSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: JSizes.spaceBtwSections, top: JSizes.md),
              child: Positioned(
                  bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                  left: 0,
                  right: 0,
                  child:
                      StepIndicator(currentIndex: currentStep, totalSteps: 4)),
            ),
          ],
        ),
      ),
    );
  }
}
