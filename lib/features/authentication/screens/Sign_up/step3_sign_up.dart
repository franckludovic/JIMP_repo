import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_wigets/custom_dropDown.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step4_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../common/widgets/link_input_fields/linkInputFields.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../common/widgets/texts/textArea.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers.onboarding/sign_up/sign_up_controller.dart';

class CandidateRegisterScreen3 extends StatefulWidget {
  const CandidateRegisterScreen3({super.key});

  @override
  State<CandidateRegisterScreen3> createState() => _CandidateRegisterScreen3State();
}

class _CandidateRegisterScreen3State extends State<CandidateRegisterScreen3> {
  int currentStep = 2;
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Resume info",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                // Skip action (if needed, you can clear fields or set defaults)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: JColors.primary,
                padding: EdgeInsets.symmetric(
                  horizontal: JSizes.md,
                  vertical: JSizes.sm,
                ),
              ),
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Self Description (bound to controller.selfDescription)
              JTextArea(

                hintText:
                "Brief Description just to know you and your career objectives and dream",
                label: const Text("Self Description"),
                controller: controller.selfDescription,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Upload Resume (assuming the widget returns a file URL via onFileUploaded callback)
              DocumentUploadWidget(
                title: "Upload Resume",
                onFileUploaded: (fileUrl) {
                  controller.resume.text = fileUrl;
                },
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Opportunity Type Dropdown
              Row(
                children: [

                  SizedBox(
                    width: JDeviceUtils.getScreenWidth(context)/2.5,
                    child: Obx(() => CustomDropDown(
                        label: "Opportunity Type",
                        value: controller.opportunityType.value,
                        items: const ["Job", "Internship", 'Contract', 'Hybrid'],
                        onChanged: (val) {
                          if (val != null) controller.opportunityType.value = val;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: JSizes.md),

                  SizedBox(
                    width: JDeviceUtils.getScreenWidth(context)/2.5,
                    child: Obx(() => CustomDropDown(
                        label: "Category",
                        value: controller.jobCategory.value,
                        items: const ["Full Time", "Part Time", 'Contract', 'Hybrid'],
                        onChanged: (val) {
                          if (val != null) controller.jobCategory.value = val;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Linked Accounts
              LinkInputWidget(
                title: "LinkedIn",
                defaultUrl: "https://linkedin.com/in/yourprofile",
                controller: controller.linkedin,
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              LinkInputWidget(
                title: "GitHub",
                defaultUrl: "https://github.com/yourusername",
                controller: controller.github,
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              LinkInputWidget(
                title: "Portfolio",
                defaultUrl: "https://yourportfolio.com",
                controller: controller.portfolio,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              JDivider(),
            ],
          ),
        ),
      ),
      // Bottom Step Indicator and Navigation Buttons
      bottomNavigationBar:Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SignUpNavigationButtons(
          onPressed: () {
            if (controller.validateStep(3)) {
              // Proceed to next screen.
              Get.to(() => CandidateRegisterScreen4());
            } else {
              TLoaders.warningSnackBar(
                title: 'Missing Information',
                message: 'Please fill in all required fields before proceeding.',
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: JSizes.spaceBtwSections, top: JSizes.md),
          child: SizedBox(
            height: 50, // Define a fixed height
            child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
          ),
        ),
      ],
    ),

    );
  }
}
