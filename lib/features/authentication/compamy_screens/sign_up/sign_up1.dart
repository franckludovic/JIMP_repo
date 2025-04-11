import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up2.dart';
import 'package:project_bc_tuto/common/widgets/custom_wigets/jcustom_dropdown.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';
import 'package:project_bc_tuto/utils/validators/validation.dart';
import '../../../../common/image_picker/image_picker.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';
import '../../screens/Sign_up/widgets/step_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompanySignUpScreen1 extends StatelessWidget {
  CompanySignUpScreen1({super.key});

  static List<String> companySize = [
    'Small (~499)',
    'Medium (500 ~ 1000)',
    'Large (1001 ~)'
  ];

  @override
  Widget build(BuildContext context) {
    int currentStep = 0;
    final controller = Get.put(CompanySignupController());

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'Basic Information',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKeyStep1,
          child: Padding(
            padding: const EdgeInsets.all(JSizes.spaceBtwItems),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.companyName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Company Name', value),
                  decoration: const InputDecoration(
                    labelText: "Company Name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.officialEmail,
                  validator: (value) => TValidator.validateEmail(value),
                  decoration: const InputDecoration(
                    labelText: JTexts.email,
                    prefixIcon: Icon(Iconsax.direct),
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber1,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    labelText: "Address line 1",
                    prefixIcon: Icon(Iconsax.call),
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber2,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    labelText: "Address line 2",
                    prefixIcon: Icon(Iconsax.call),
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    validator: (value) => TValidator.validatePassword(value),
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      labelText: JTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(

                              child: ImageUploadWidget(
                                title: 'Profile Picture',
                                onUploadCompleted: (url) {
                                  controller.profileUrl.text = url;
                                },
                              ),
                            ),
                            const SizedBox(width: JSizes.md),
                            Expanded(
                              child: ImageUploadWidget(
                                title: 'Logo',
                                onUploadCompleted: (url) {
                                  controller.logoUrl.text = url;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: JSizes.md),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.country,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Country', value),
                                decoration:
                                    const InputDecoration(labelText: 'Country'),
                              ),
                            ),
                            const SizedBox(width: JSizes.md),
                            Expanded(
                              child: TextFormField(
                                controller: controller.region,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Region', value),
                                decoration:
                                    const InputDecoration(labelText: 'Region'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: JSizes.spaceBtwItems * 1.5),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.city,
                                validator: (value) =>
                                    TValidator.validateEmptyText('City', value),
                                decoration:
                                    const InputDecoration(labelText: 'City'),
                              ),
                            ),
                            const SizedBox(width: JSizes.md),
                            Expanded(
                              child: TextFormField(
                                controller: controller.localAddress,
                                validator: (value) =>
                                    TValidator.validateEmptyText(
                                        'Local Address', value),
                                decoration: const InputDecoration(
                                    labelText: 'Local Address'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: JSizes.spaceBtwInputFields),
                        Obx(
                          () => JCustomDropDown(
                            title: 'Company Size(Employees) :',
                            items: companySize.isEmpty
                                ? ['Select an option']
                                : companySize,
                            value: controller.companySize.value.isEmpty
                                ? null
                                : controller.companySize.value,
                            hint: "Select Employee Count",
                            onChanged: (val) {
                              if (val != null) {
                                controller.companySize.value = val;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwInputFields),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: JSizes.sm),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: JColors.primary,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                if (controller.validateStep1()) {
                  Get.to(() => CompanySignupScreen2());
                } else {
                  JLoaders.warningSnackBar(
                    title: 'Missing Information',
                    message:
                        'Please correctly fill in all required fields before proceeding.',
                  );
                }
              },
              child: const Text(
                "Next Step",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: JSizes.spaceBtwSections, top: JSizes.md),
            child: Positioned(
              bottom: JDeviceUtils.getBottomNavigationBarHeight(),
              left: 0,
              right: 0,
              child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
            ),
          ),
        ],
      ),
    );
  }
}
