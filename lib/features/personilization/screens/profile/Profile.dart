import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/Jcircular_image.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/personilization/screens/profile/widgets/profile_menu.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    JCircularImage(image: JImages.user2, width: 100, height: 100),
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

              JProfileMenu(title: 'Name', value: 'Elsa Luciens', onPressed: () {},),
              JProfileMenu(title: 'Username', value: 'Entropy', onPressed: () {},),

              const SizedBox(height: JSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems),

              const JSectionHeading(title: "Persomal information", showActonButton: false),
              const SizedBox(height: JSizes.spaceBtwItems),

              JProfileMenu(title: 'User_id', value: '7896545', icon: Iconsax.copy, onPressed: () {},),
              JProfileMenu(title: 'E-mails', value: 'elsascarlet@gmail.com', onPressed: () {},),
              JProfileMenu(title: 'Phone number', value: '+237 677 88 99 22', onPressed: () {},),
              JProfileMenu(title: 'Gender', value: 'Genderless', onPressed: () {},),
              JProfileMenu(title: 'Date of birth', value: '10 *&!#, 1000 ', onPressed: () {},),

              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems/2),

              Center(
                child: TextButton(
                    onPressed: () {},
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

