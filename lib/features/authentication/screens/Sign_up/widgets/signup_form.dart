import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';


import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../verify_email.dart';


class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: JTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),

              const SizedBox(width: JSizes.spaceBtwInputFields),

              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: JTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: JTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: JTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Phone number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: JTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: JTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Term & conditions
          const TermandConditions(),

          const SizedBox(height: JSizes.spaceBtwSections),

          ///Sign up button
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const VerifyEmailScreen() ), child: const Text(JTexts.createAccount))),
        ],
      ),
    );
  }
}

