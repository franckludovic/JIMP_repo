import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/validators/validation.dart';

import '../../../../../utils/constants/text_strings.dart';
import '../../controllers/update_name_controler.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: JAppbar(
        title: Text('Re-Authenticate User', style: Theme.of(context).textTheme.headlineMedium,),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: controller.reAuthFormkey ,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.verifyEmail,
                      validator:(value) => TValidator.validateEmail(value),
                      expands: false,
                      decoration: const InputDecoration(labelText: JTexts.email, prefixIcon: Icon(Iconsax.direct_right)),
                    ),

                    const SizedBox(height: JSizes.inputFieldRadius,),

                    Obx(
                          () => TextFormField(
                        controller: controller.verifyPassword,
                        validator: (value) =>
                            TValidator.validatePassword(value),
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
                  ],
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwSections,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
              )


            ],
          ),
        ),
      ),
    );
  }
}
