import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step2_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/image_picker/image_picker.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers.onboarding/sign_up/sign_up_controller.dart';


class CandidateRegisterScreen1 extends StatefulWidget {
  const CandidateRegisterScreen1({super.key});

  @override
  State<CandidateRegisterScreen1> createState() => _CandidateRegisterScreen1State();
}

class _CandidateRegisterScreen1State extends State<CandidateRegisterScreen1> {
  int currentStep = 0;


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignupController());
    return Scaffold(

      appBar: JAppbar(title: Text(
        "Profile Information Screen",
        style: Theme.of(context).textTheme.headlineMedium,
      ),),
      body: SingleChildScrollView(
        child:Form(
          key: controller.signupFormKey,
          child: Padding(
            padding: const EdgeInsets.all(JSizes.spaceBtwItems),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.firstName,
                        validator: (value) =>
                            TValidator.validateEmptyText('First name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: JTexts.firstName,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                    ),
                    const SizedBox(width: JSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName,
                        validator: (value) =>
                            TValidator.validateEmptyText('Last name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: JTexts.lastName,
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: JSizes.spaceBtwInputFields),

                ///Username
                TextFormField(
                  controller: controller.username,
                  validator: (value) =>
                      TValidator.validateEmptyText('Username', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: JTexts.username,
                      prefixIcon: Icon(Iconsax.user_edit)),
                ),

                const SizedBox(height: JSizes.spaceBtwInputFields),

                ///Email
                TextFormField(
                  controller: controller.email,
                  validator: (value) => TValidator.validateEmail(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: JTexts.email, prefixIcon: Icon(Iconsax.direct)),
                ),

                const SizedBox(height: JSizes.spaceBtwInputFields),

                ///Phone number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: JTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
                ),

                const SizedBox(height: JSizes.spaceBtwInputFields),


                ///password without library
                Obx(
                      () =>  TextFormField(
                    controller: controller.password,
                    validator: (value) => TValidator.validatePassword(value),
                    obscureText: controller.hidePassword.value,
                    expands: false,
                    decoration: InputDecoration(
                        labelText: JTexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon:
                        IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                            icon:  Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye))),
                  ),
                ),

                ///Password with FancyPassword library
                // FancyPasswordField(
                //   controller: controller.password,
                //   validator: (value) => TValidator.validatePassword(value),
                //   obscureText: controller.hidePassword.value,
                //   decoration: InputDecoration(
                //     labelText: "Password",
                //     prefixIcon: const Icon(Iconsax.password_check),
                //     hintText: "At least 8 characters",
                //   ),
                // ),

                const SizedBox(height: JSizes.spaceBtwInputFields),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Username Field

                    // Profile Image Upload Button

                    // DocumentUploadWidget(title: 'Profile Picture', documentType: 'PNG, JPG', onFileUploaded: (fileUrl) {
                    //   controller.profileUrl.text = fileUrl;
                    // },),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Profile Image', style: Theme.of(context).textTheme.bodyLarge,),
                        ImageUploadWidget(
                          title: 'Profile Image',
                          onUploadCompleted: (url) {
                            controller.profileUrl.text = url;
                          },
                        ),
                      ],
                    ),


                    const SizedBox(height: JSizes.md),

                    // Dropdowns
                    Row(
                      children: [
                        Expanded(child: TextFormField(
                          controller: controller.country,
                            validator: (value) => TValidator.validateEmptyText('Country', value),
                            expands: false,
                            decoration: const InputDecoration(labelText: 'Country')),
                        ),
                        const SizedBox(width: JSizes.md),
                        Expanded(child: TextFormField(
                            controller: controller.region,
                            validator: (value) => TValidator.validateEmptyText('Region', value),
                            expands: false,
                            decoration: const InputDecoration(labelText: 'Region')),),
                      ],
                    ),

                    const SizedBox(height: JSizes.spaceBtwItems * 1.5),

                    Row(
                      children: [
                        Expanded(child: TextFormField(
                            controller: controller.city,
                            validator: (value) => TValidator.validateEmptyText('city', value),
                            expands: false,
                            decoration: const InputDecoration(labelText: 'City')),
                        ),
                        const SizedBox(width: JSizes.md),
                        Expanded(child: TextFormField(
                            controller: controller.localAddress,
                            validator: (value) => TValidator.validateEmptyText('localAddress', value),
                            expands: false,
                            decoration: const InputDecoration(labelText: 'Local Address')),),
                      ],
                    ),
                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    TextFormField(
                      controller: controller.educationLevel,
                        validator:(value) => TValidator.validateEmptyText('educationLevel', value),
                        expands: false,
                        decoration: const InputDecoration(labelText: 'Education Level')),
                    const SizedBox(width: JSizes.spaceBtwInputFields),

                    const SizedBox(height: JSizes.spaceBtwInputFields),

                    TextFormField(
                        controller: controller.schoolAttended,
                        validator:(value) => TValidator.validateEmptyText('schoolAttended', value),
                        expands: false,
                        decoration: const InputDecoration(labelText: 'School Last attended')),
                    const SizedBox(width: JSizes.spaceBtwInputFields),

                    // Bottom Step Indicator
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
                if (controller.validateStep(1)) {
                  // Proceed to next screen.
                  Get.to(() => CandidateRegisterScreen2());
                } else {
                  JLoaders.warningSnackBar(
                    title: 'Missing Information',
                    message: 'Please fill in all required fields before proceeding.',
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

