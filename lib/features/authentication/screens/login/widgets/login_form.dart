import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/password_configuration/forget_password.dart';

import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {

  const TLoginForm({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Form(

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: JSizes.spaceBtwSections),
        child: Column(
          children: [
            ///email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TTexts.email
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),

            ///password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
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
                    Checkbox(value: true, onChanged: (value){}), // Corrected onChanged
                    const Text(TTexts.rememberMe),
                  ],
                ),
                /// forgot password
                TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(TTexts.forgetPassword)),
              ],
            ),

            ///sign in button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.off(() => const NavigationMenu()), child: Text(TTexts.signIn))),
            const SizedBox(height: JSizes.spaceBtwItems),

            ///create account button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}