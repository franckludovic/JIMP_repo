import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../../common/widgets/custom_wigets/custom_dropDown.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class JSignUpCompanypage1 extends StatelessWidget {
  const JSignUpCompanypage1({
    super.key,
  });


  @override
  Widget build(BuildContext context) {


    return Form(
      child: Column(
        children: [

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),

          ///Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: JTexts.username, prefixIcon: Icon(Iconsax.user_edit)),
          ),

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),

          ///Email
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: JTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),

          ///Phone number
          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: "Address line1", prefixIcon: Icon(Iconsax.call)),

          ),

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),


          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: "Address line2(Optional)", prefixIcon: Icon(Iconsax.call)),

          ),

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),

          TextFormField(
            expands: false,
            decoration: const InputDecoration(labelText: "Web site(Optional)", prefixIcon: Icon(Iconsax.global_search)),

          ),

          const SizedBox(height: JSizes.spaceBtwSections* 0.8),

         buildDropdown('Industry'),


          const SizedBox(height: JSizes.spaceBtwSections* 0.8),


         TextFormField(
              expands: false,
              decoration: const InputDecoration(labelText: 'Company Size', prefixIcon: Icon(Iconsax.user)),
            ),



          const SizedBox(height: JSizes.spaceBtwSections *0.8),



          ///Sign up button

        ],
      ),
    );
  }
}

