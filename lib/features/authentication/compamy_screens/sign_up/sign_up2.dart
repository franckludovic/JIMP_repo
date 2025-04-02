import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up3.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_wigets/jcustom_dropdown.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../common/widgets/link_input_fields/linkInputFields.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../common/widgets/texts/textArea.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';
import '../../screens/Sign_up/widgets/step_indicator.dart';

class CompanySignupScreen2 extends StatelessWidget {
   CompanySignupScreen2({super.key});


  final List<String> industries = [
    "Technology", "Healthcare",
    "Finance", "Education",
    "Retail", "Hospitality",
    "Manufacturing", "Engineering",
    "Law", "Real Estate",
    "Media", "Entertainment",
    "Energy", "Telecommunications",
    "Transportation", "Logistics",
    "Agriculture", "Pharmaceutical",
    "Construction", "Non-Profit",
    "Government", "E-commerce",
    "Consulting", "Automotive",
    "Aerospace", "Food and Beverage",
    "Tourism", "Renewable Energy",
    "IT", "Marketing",
    "Advertising", "Fashion",
    "Sports", "Arts",
    "Petroleum", "Mining",
    "Biotechnology", "Insurance",
    "Aviation", "Shipping",
    "Electronics", "Chemical",
    "Paper", "Textile"
  ];



   final List<String> opportunityType = [
     'Internship',
     'Job',
     'Hybrid'
   ];


   final List<String> opportunityCategory = [
     'Full-time',
     'Part-time',
     'Contract',
     'Hybrid'
   ];


   @override
    Widget build(BuildContext context) {
      int currentStep = 1;
      final controller = Get.put(CompanySignupController());
      return Scaffold(
        appBar: JAppbar(
          title: Text("Contact  & Business  ",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: controller.formKeyStep2 ,
              child: Padding(
                padding: const EdgeInsets.all(JSizes.spaceBtwItems),
                child: Column(
                  children: [

                    //Registration NO
                    TextFormField(
                      controller: controller.registrationNumber,
                      validator: (value) => TValidator.validateEmptyText('Registration number ',value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: "Registration number"),
                    ),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                   //Description
                    TextFormField(
                      controller: controller.description,
                      validator: (value) => TValidator.validateEmptyText('Description ',value),
                      expands: false,
                      minLines: 7,
                      maxLines: 7,
                      scrollPhysics: AlwaysScrollableScrollPhysics(),
                      decoration: const InputDecoration(
                          labelText: 'Description'),
                    ),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    LinkInputWidget(title: "LinkedIn", defaultUrl: "https://linkedin.com/in/yourprofile", controller: controller.linkedinProfile,),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    LinkInputWidget(title: "Website", defaultUrl: "https://yourwebsite.com", controller: controller.website,),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    DocumentUploadWidget(title: 'Business Licence', documentType: 'PDF',
                      onFileUploaded: (fileUrl) {
                        controller.businessLicense.text = fileUrl;
                      },
                    ),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    Obx(() => JCustomDropDown(
                      title: 'Industries :',
                      items: industries.isEmpty ? ['Select an option'] : industries,
                      value: controller.industry.value.isEmpty ? null : controller.industry.value,
                      hint: "Select Industry",
                      onChanged: (value) {
                        if (value != null) controller.industry.value = value;
                      },
                    )),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    Obx(() => JCustomDropDown(
                      title: 'Company Size(Employees) :',
                      items: opportunityType.isEmpty ? ['Select an option'] : opportunityType,
                      value: controller.opportunityType.value.isEmpty ? null : controller.opportunityType.value,
                      hint: "Select opportunity type",
                      onChanged: (val) {
                        if (val != null) controller.opportunityType.value = val;
                      },
                    ),
                    ),

                    const SizedBox(height: JSizes.spaceBtwInputFields),


                    Obx(() => JCustomDropDown(
                      title: 'Opportunity category :',
                      items: opportunityCategory.isEmpty ? ['Select an option'] : opportunityCategory,
                      value: controller.opportunityCategory.value.isEmpty ? null : controller.opportunityCategory.value,
                      hint: "Select opportunity category",
                      onChanged: (value) {
                        if (value != null) controller.opportunityCategory.value = value;
                      },
                    )),
                  ],
                ),

              ),
          ),
        ),

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SignUpNavigationButtons(onPressed: () {
              if (controller.validateStep2()) {
                // Proceed to next screen.
                Get.to(() => CompanySignUpScreen3());
              } else {
                TLoaders.warningSnackBar(
                  title: 'Missing Information',
                  message: 'Please correctly fill in all required fields before proceeding.',
                );
              }
            }),
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
      );
  }
}
