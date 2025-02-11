import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import 'package:project_bc_tuto/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';
import '../../../../common/widgets/documents_cad/resumer_card.dart';
import '../../../../common/widgets/documents_cad/skills_card.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/sizes.dart';
import '../profile/Profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///---Header
            JPrimaryHeaderContainer(
              child: Column(
                children: [
                  JAppbar(
                      title: Text('Account',
                          style: Theme.of(context).textTheme.headlineMedium!.apply(color: JColors.white))),
                  const SizedBox(height: JSizes.spaceBtwSections * 0.5),

                  ///user Profile card
                  JUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen()),),
                  const SizedBox(height: JSizes.spaceBtwSections),
                ],
              ),
            ),

            ///---Body
            Padding(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                children: [
                  JResumeCard(title: "Resume", fileName: "Franck's Resume"),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  JSectionHeading(title: "Skills", onPressed: () {} ),
                  JSkillsCard(
                      skills: [
                        JCircularSkillIndicator(percentage: 0.8, textPercent: '85%', bottomText: 'Python', progressColor: Colors.greenAccent),
                        JCircularSkillIndicator(percentage: 0.2, textPercent: '20%', bottomText: 'React Js', progressColor: Colors.redAccent),
                        JCircularSkillIndicator(percentage: 0.6, textPercent: '60%', bottomText: 'Java', progressColor: Colors.purple),
                        JCircularSkillIndicator(percentage: 0.5, textPercent: '40%', bottomText: 'Flutter programing', progressColor: Colors.blue),

                      ],
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  ///Account Settings
                  const JSectionHeading(
                      title: "Account Settings", showActonButton: false),
                  const SizedBox(height: JSizes.spaceBtwItems),

                  JSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My address",
                    subtitle: "Ready to be Called",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.document_text5,
                    title: "My applications",
                    subtitle: "Apply, remove, drop-out",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.task_square,
                    title: "My Contracts",
                    subtitle: "On going jobs ",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.briefcase,
                    title: "My proposals",
                    subtitle: "Offers Received",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.profile_2user,
                    title: "My Network",
                    subtitle: "You connection with people ",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Get any kind of updates",
                    onTap: () {},
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subtitle: "Manage data usage and connected account",
                    onTap: () {},
                  ),

                  ///--App settings
                  SizedBox(height: JSizes.spaceBtwSections),
                  JSectionHeading(
                      title: "App Settings", showActonButton: false),
                  SizedBox(height: JSizes.spaceBtwItems),
                  JSettingsMenuTile(
                      icon: Iconsax.document_upload,
                      title: "Load Data",
                      subtitle: "Upload your project"),
                  JSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe mode",
                    subtitle: "filter on Certified jobs",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subtitle: "Set recommendations based on locations",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.lock,
                    title: "Visibility",
                    subtitle: "Make your account Private",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),

                  ///-- Log out button
                  const SizedBox(height: JSizes.spaceBtwSections * 2.5),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(side: BorderSide(width: 5, color: JColors.primary)) ,

                        onPressed: () {}, child: const Text("Log out", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20))),
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections * 2.5),




                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
