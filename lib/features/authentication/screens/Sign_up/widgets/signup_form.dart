import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step2_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';


import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class JSignupStep1Form extends StatelessWidget {
  const JSignupStep1Form({
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
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(() => const CandidateRegisterScreen2() ),
             style: ElevatedButton.styleFrom(
               padding: EdgeInsets.symmetric(vertical: JSizes.sm, horizontal: JSizes.lg)
             ),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(JTexts.MoveToNext, style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),),
                    SizedBox(width: JSizes.lg,),
                    Icon(Iconsax.arrow_right_2, size: 50,)
                  ],
                )
          )
          ),
        ],
      ),
    );
  }
}

