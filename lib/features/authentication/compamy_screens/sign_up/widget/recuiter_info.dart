import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../common/widgets/Images/Jcircular_image.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../personilization/screens/profile/widgets/profile_menu.dart';

class RecruiterInfo extends StatelessWidget {
  const RecruiterInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Text("Recruiter Info", style: Theme.of(context).textTheme.headlineMedium,), showBackArrow: true,),
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
              const SizedBox(height: JSizes.spaceBtwItems *0.8),
              const JSectionHeading(title: "Profile information", showActonButton: false),
              const SizedBox(height: JSizes.spaceBtwItems *0.8),

              JProfileMenu(title: 'Name', value: 'Elsa Luciens', onPressed: () {},),
              JProfileMenu(title: 'Username', value: 'Entropy', onPressed: () {},),

              const SizedBox(height: JSizes.spaceBtwItems *0.8),
              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems * 0.8),

              const JSectionHeading(title: "Personal information", showActonButton: false),
              const SizedBox(height: JSizes.spaceBtwItems *0.8),

              JProfileMenu(title: 'User_id', value: 'GNX001235', icon: Iconsax.copy, onPressed: () {},),
              JProfileMenu(title: 'Company', value: 'Genesix', icon: Iconsax.buildings, onPressed: () {},),
              JProfileMenu(title: 'Position', value: 'Senior engineer', icon: Iconsax.user, onPressed: () {},),
              JProfileMenu(title: 'E-mails', value: 'elsascarlet@gmail.com', onPressed: () {},),
              JProfileMenu(title: 'Address Line 1', value: '+237 677 88 99 22', onPressed: () {},),
              JProfileMenu(title: 'Address Line 2', value: '+237 677 88 99 22', onPressed: () {},),
              JProfileMenu(title: 'Gender', value: 'Genderless', onPressed: () {},),

              const Divider(),
              const SizedBox(height: JSizes.spaceBtwItems/2),

              ///delete recruiter
              TextButton(onPressed: () {}, child: Text("Delete Recruiter", style: TextStyle(color: Colors.red, fontSize: 25, ),))

            ],
          ),
        ),
      ),
    );
  }
}
