import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/Jcircular_image.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/personilization/screens/profile/widgets/change_name.dart';
import 'package:project_bc_tuto/features/personilization/screens/profile/widgets/profile_menu.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: JAppbar(
        title: Text("Profile"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircleAvatar( backgroundImage:AssetImage(JImages.user2) , radius: 70, ),
                    TextButton(onPressed: () {}, child: const Text("Change profile picture")),
                  ],
                ),
              ),

              ///Details
              const SizedBox(height: JSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems),
              const JSectionHeading(title: "Profile information", showActonButton: false),
              const SizedBox(height: JSizes.spaceBtwItems),

              JProfileMenu(title: 'Name', value: controller.user?.fullName ?? '', onPressed: () => Get.to(() => const ChangeName()),),
              JProfileMenu(title: 'Username', value: controller.user?.username ?? '', onPressed: () {},),

              const SizedBox(height: JSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems),

              const JSectionHeading(title: "Persomal information", showActonButton: false),
              const SizedBox(height: JSizes.spaceBtwItems),

              JProfileMenu(title: 'User_id', value: controller.user?.id ?? '', icon: Iconsax.copy, onPressed: () {},),
              JProfileMenu(title: 'E-mails', value: controller.user?.email ?? '', onPressed: () {},),
              JProfileMenu(title: 'Phone number', value: controller.user?.phoneNumber ?? '', onPressed: () {},),
              JProfileMenu(title: 'Gender', value: 'Genderless', onPressed: () {},),
              JProfileMenu(title: 'Date of birth', value: '10 *&!#, 1000 ', onPressed: () {},),

              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems/2),

              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarning(),
                    child: const Text("Close Account", style: TextStyle(color: Colors.red, fontSize: 20)),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

}


