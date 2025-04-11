import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_upReview.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/add_branch.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/validators/validation.dart';
import '../../../Applications/models/company_model.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';
import '../../screens/Sign_up/widgets/step_indicator.dart';

class CompanySignUpScreen3 extends StatelessWidget {
  const CompanySignUpScreen3({super.key});


  @override
  Widget build(BuildContext context) {

    int currentStep = 2;
    final controller = Get.put(CompanySignupController());
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          "HR & Branch Information",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JSizes.spaceBtwItems),
        child: Form(
          key: controller.formKeyStep3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HR Contact Information Section
              Text("HR Contact Information", style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.hrName,
                decoration: const InputDecoration(labelText: "HR Name", prefixIcon: Icon(Iconsax.user)),
                validator: (value) => TValidator.validateEmptyText('Hr Name', value),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.hrTitle,
                decoration: const InputDecoration(labelText: "HR Title", prefixIcon: Icon(Icons.badge) ),
                validator: (value) => TValidator.validateEmptyText('Hr Title', value),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.hrEmail,
                decoration: const InputDecoration(labelText: "HR Email",  prefixIcon: Icon(Iconsax.direct)),
                validator:(value) => TValidator.validateEmail(value)
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: controller.hrPhone,
                decoration: const InputDecoration(labelText: "HR Phone",  prefixIcon: Icon(Iconsax.call)),
                validator:  (value) => TValidator.validatePhoneNumber(value),
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems),

              // Branch Information Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Branch Information", style: Theme.of(context).textTheme.headlineSmall),
                  TextButton(
                    onPressed: () {

                      controller.branches.add(
                        
                        CompanyBranch(
                          address: CompanyAddress(
                            street: "",
                            city: "",
                            country: "",
                            region: "",
                            postalCode: "",
                          ),
                          contactEmail: "",
                          phoneNumber: "",
                          contactName: "",
                        ),
                      );
                    },
                    child: const Text("Add Branch"),
                  ),
                ],
              ),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.branches.length,
                  itemBuilder: (context, index) {
                    return BranchCardWidget(
                      index: index,
                      branch: controller.branches[index],
                      onChanged: (updatedBranch) {
                        // Replace the branch at the given index with the updated branch.
                        controller.branches[index] = updatedBranch;
                      },
                      onRemove: () {
                        controller.branches.removeAt(index);
                      },
                    );
                  },
                );
              }),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SignUpNavigationButtons(onPressed: () {
            if (controller.validateStep3()) {
              // Proceed to next screen.
              Get.to(() => CompanySignUpReview());
            } else {
              JLoaders.warningSnackBar(
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
