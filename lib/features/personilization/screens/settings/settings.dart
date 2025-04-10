import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import 'package:project_bc_tuto/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/data/repositories/authentication/authentication_repositories.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications_applied/applied.dart';
import 'package:project_bc_tuto/features/Applications/screens/notifications/notifications.dart';
import 'package:project_bc_tuto/features/personilization/screens/address/address.dart';
import 'package:project_bc_tuto/features/personilization/screens/profile/Profile.dart';
import 'package:project_bc_tuto/features/personilization/screens/settings/skill%20card%20drawer.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';
import '../../../../common/widgets/documents_cad/resumer_card.dart';
import '../../../../common/widgets/documents_cad/skills_card.dart';
import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../Applications/screens/ongoing_contracts/contract_page.dart';
import '../../../Applications/screens/proposals_page/proposal_page.dart';
import '../../../Applications/screens/type_user/type_user_page.dart';
import '../../controllers/user_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
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
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: JColors.white))),
                  const SizedBox(height: JSizes.spaceBtwSections * 0.5),

                  ///user Profile card
                  JUserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections),
                ],
              ),
            ),

            ///---Body
            Padding(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                children: [
                  JResumeCard(title: "Resume", fileName: "${controller.user?.username ?? ""}'s Resume"),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  JSectionHeading(title: "Skills", onPressed: () {}),

                  Obx(() => CandidateSkillsList(
                    skills: controller.user!.skills, // assuming skillEntries is your RxList<SkillEntry>
                  )),

                  const SizedBox(height: JSizes.spaceBtwSections),

                  ///Account Settings
                  const JSectionHeading(
                      title: "Account Settings", showActonButton: false),
                  const SizedBox(height: JSizes.spaceBtwItems),

                  JSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My address",
                    subtitle: "Ready to be Called",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.document_text5,
                    title: "My applications",
                    subtitle: "See Status, drop out",
                    onTap: () => Get.to(() => const ApplicationsApplied()),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.task_square,
                    title: "My Contracts",
                    subtitle: "On going jobs ",
                    onTap: () => Get.to(() => OngoingContractsPage()),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.briefcase,
                    title: "My proposals",
                    subtitle: "Offers Received",
                    onTap: () => Get.to(() => ProposalPage()),
                  ),

                  JSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Get any kind of updates",
                    onTap: () => Get.to(() => const JNotificationScreen()),
                  ),

                  // JSettingsMenuTile(
                  //   icon: Iconsax.security_card,
                  //   title: "Account Privacy",
                  //   subtitle: "Manage data usage and connected account",
                  //   onTap: () {},
                  // ),

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

                  ///change account type
                  SizedBox(
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => JTypeUser()),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,

                              side: BorderSide(color: JColors.primary, width: 2, ),
                              padding: EdgeInsets.symmetric(
                                  vertical: JSizes.md, horizontal: JSizes.lg)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Change Account type",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Icon(
                                Iconsax.arrow_swap_horizontal,
                                size: 30,
                              ),
                            ],
                          )
                      )
                  ),

                  ///-- Log out button
                  const SizedBox(height: JSizes.spaceBtwSections * 2.5),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () => AuthenticationRepository.instance.logout(),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: JSizes.md),
                            backgroundColor: JColors.primary.withAlpha((0.8 * 255).toInt())
                          ),
                          child: Text(
                            "Log out",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ))),
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
