import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/sign_up/sign_up_controller.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class JSignupStep1Form extends StatelessWidget {
  const JSignupStep1Form({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
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

          ///Term & conditions
          const TermandConditions(),

          const SizedBox(height: JSizes.spaceBtwSections),

          Container(
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: JSizes.sm, horizontal: JSizes.lg)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      JTexts.MoveToNext,
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    ),
                    SizedBox(
                      width: JSizes.lg,
                    ),
                    Icon(
                      Iconsax.arrow_right_2,
                      size: 50,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
