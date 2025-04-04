import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/validators/validation.dart';

import '../../../../../utils/constants/text_strings.dart';
import '../../controllers/update_name_controler.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: JAppbar(
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineMedium,),
      ),

      body: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification, This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(height: JSizes.spaceBtwSections,),

            Form(
              key: controller.updateUserFormKey ,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) => TValidator.validateEmptyText('First Name', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: JTexts.firstName, prefixIcon: Icon(Iconsax.user)),
                    ),

                    const SizedBox(height: JSizes.inputFieldRadius,),

                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) => TValidator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: JTexts.lastName, prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                ),
            ),
            const SizedBox(height: JSizes.spaceBtwSections,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save')),
            )


          ],
        ),
      ),
    );
  }
}
