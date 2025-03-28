import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';


import '../../../../../common/widgets/custom_wigets/custom_textfield.dart';
import '../../../../../common/widgets/documents_cad/file_picker_card.dart';
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
          FancyPasswordField(
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Iconsax.password_check),
              hintText: "At least 8 characters",
            ),
          ),

          const SizedBox(height: JSizes.spaceBtwItems * 1.5),

          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Username Field

                  // Profile Image Upload Button

                  DocumentUploadWidget(title: 'Profile Picture', documentType: 'PNG, JPG'),


                  const SizedBox(height: JSizes.md),

                  // Dropdowns
                  Row(
                    children: [
                      Expanded(child: TextFormField(
                          expands: false,
                          decoration: const InputDecoration(labelText: 'Country')),
                      ),
                      const SizedBox(width: JSizes.md),
                      Expanded(child: buildTextField("Region")),
                    ],
                  ),

                  const SizedBox(height: JSizes.spaceBtwItems * 1.5),

                  Row(
                    children: [
                      Expanded(child: TextFormField(
                          expands: false,
                          decoration: const InputDecoration(labelText: 'City')),
                      ),
                      const SizedBox(width: JSizes.md),
                      Expanded(child: buildTextField("Local address")),
                    ],
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems * 2),

                  TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: 'Education Level')),
                  const SizedBox(height: JSizes.spaceBtwItems * 2),

                  TextFormField(
                      expands: false,
                      decoration: const InputDecoration(labelText: 'School Last attended')),
                  const SizedBox(height: JSizes.spaceBtwItems * 2),

                  // Bottom Step Indicator
                ],
              ),

            ],
          ),

          const SizedBox(height: JSizes.spaceBtwInputFields),

          ///Term & conditions
          const TermandConditions(),

          const SizedBox(height: JSizes.spaceBtwSections),
        ],
      ),
    );
  }
}

