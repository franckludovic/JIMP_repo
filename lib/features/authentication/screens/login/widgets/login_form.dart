import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/controllers.onboarding/login/login_controller.dart';

import 'package:project_bc_tuto/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:project_bc_tuto/utils/validators/validation.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../Sign_up/step1_sign_up.dart';

class JLoginForm extends StatelessWidget {
  const JLoginForm({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: JSizes.spaceBtwSections),
        child: Column(
          children: [
            ///email
            TextFormField(
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: JTexts.email),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),

            ///password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                expands: false,
                decoration: InputDecoration(
                    labelText: JTexts.password,
                    prefixIcon: const Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye))),
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields / 2),

            ///remember me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// remember me
                Row(
                  children: [
                    Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value)),
                    // Corrected onChanged
                    const Text(JTexts.rememberMe),
                  ],
                ),

                /// forgot password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(JTexts.forgetPassword)),
              ],
            ),

            ///sign in button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: JSizes.md * 0.8)
                  ),
                    onPressed: () => controller.emailAndPasswordSignIN(),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    ))),
            const SizedBox(height: JSizes.spaceBtwItems),

            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: onPressed,
                    child: Text(JTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
