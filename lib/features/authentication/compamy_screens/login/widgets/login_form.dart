import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/password_configuration/forget_password.dart';

import '../../../../../navigation_menu_company.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../sign_up/sign_up1.dart';


class JLoginForm2 extends StatelessWidget {

  const JLoginForm2({
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
                  labelText: JTexts.email
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),

            ///password
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: JTexts.password,
                suffixIcon: IconButton( onPressed: () {}, icon: const Icon(Iconsax.eye_slash)),
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
                    const Text(JTexts.rememberMe),
                  ],
                ),
                /// forgot password
                TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: const Text(JTexts.forgetPassword)),
              ],
            ),

            ///sign in button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed:() => Get.offAll( const CompanyNavigationMenu()), child: Text(JTexts.signIn))),
            const SizedBox(height: JSizes.spaceBtwItems),

            ///create account button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() =>  CompanySignUpScreen1()), child: Text(JTexts.createAccount))),
            //SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() =>  CompanySignUpReview()), child: Text(JTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}