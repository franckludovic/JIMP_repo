import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/company_profile/widget/company_profile_stats.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/company_profile/widget/company_specialisation.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../utils/constants/colors.dart';
import '../../../personilization/screens/address/address.dart';
import '../../screens/notifications/notifications.dart';
import '../../screens/type_user/type_user_page.dart';
import '../company_details/company_details.dart';
import '../employee/employee_mangement_screen.dart';
import '../home/widgets/company_home_header.dart';
import '../myproposals/myproposals.dart';


class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CompanyHomeHeader(),

            const SizedBox(height: 16),


            // Focus or "Specialties" Section
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  CompanySpecialsationSection(),

                  // Quick Stats
                  BuildQuickProfileStat(),

                  JSettingsMenuTile(
                    icon: Iconsax.user_octagon,
                    title: "Profile",
                    subtitle: "Update your profile",
                    onTap: () => Get.to(() => CompanyProfileDetails()),
                  ),

                  JSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My address",
                    subtitle: "Ready to be Called",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),

                  JSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Get any kind of updates",
                    onTap: () => Get.to(() => const JNotificationScreen()),
                  ),

                  JSettingsMenuTile(
                    icon: FontAwesomeIcons.userTie,
                    title: "Team members",
                    subtitle: "Manage recruiters and interns",
                    onTap: () => Get.to(() => EmployeeManagementScreen()),
                  ),


                  JSettingsMenuTile(
                    icon: Iconsax.briefcase,
                    title: "My proposals",
                    subtitle: "Offers Received",
                    onTap: () => Get.to(() => Myproposals()),
                  ),


                  SizedBox(height: JSizes.spaceBtwSections,),

                  Divider(),

                  SizedBox(height: JSizes.spaceBtwSections,),

                  JSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Receive Messages",
                    subtitle: "Receive notifications from Candidates",
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  JSettingsMenuTile(
                    icon: Iconsax.lock,
                    title: "Visibility",
                    subtitle: "Make your account Private",
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(JSizes.defaultSpace),
                    child: Column(
                      children: [
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: JSizes.md),
                                    backgroundColor: JColors.primary.withAlpha((0.8 * 255).toInt())
                                ),
                                child: Text(
                                  "Log out",
                                  style: Theme.of(context).textTheme.headlineMedium,
                                )
                            )
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

