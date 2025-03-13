import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import 'features/Applications/company_creens/CompanyChats/chatHomescrenns.dart';
import 'features/Applications/company_creens/Posting/application.dart';
import 'features/Applications/company_creens/applicants/applicantsScreens.dart';
import 'features/Applications/company_creens/company_profile/company_profile.dart';
import 'features/Applications/company_creens/home/home.dart';

class CompanyNavigationMenu extends StatelessWidget {
  const CompanyNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyNavigationController());
    final darkMode = JHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      bottomNavigationBar: Obx(
        () =>  NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: darkMode? JColors.black: JColors.white,
            indicatorColor: darkMode? JColors.white.withAlpha((0.1 * 255).toInt()) : JColors.black.withAlpha((0.1 * 255).toInt()),
            destinations: [
              const NavigationDestination(icon: Icon(Iconsax.home_15, color: Colors.blueAccent,) , label:"Home"),
              const NavigationDestination(icon: Icon(Iconsax.message5, color: Colors.greenAccent) , label:"Chat"),
              const NavigationDestination(icon: Icon(FontAwesomeIcons.briefcase, color: Colors.orangeAccent) , label:"Postings"),
              const NavigationDestination(icon: Icon(Iconsax.profile_2user, color: Colors.yellow) , label:"Applicants"),
              const NavigationDestination(icon: Icon(Iconsax.profile_circle5, color: Colors.purpleAccent) , label:"Profile"),
            ]
        ),
      ),
      body: Obx(() =>  controller.screens[controller.selectedIndex.value]),
    );
  }

}

class CompanyNavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [  CompanyHome(), const ChatHomeScreen(), const CompanyApplicationScreen(), const ApplicantsScreens(), const CompanyProfilePage()];
}
