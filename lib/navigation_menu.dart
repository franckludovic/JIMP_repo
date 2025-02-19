import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications/application.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/home.dart';
import 'package:project_bc_tuto/features/personilization/screens/settings/settings.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import 'features/Applications/screens/chat/screens/chats/chats_screen.dart';
import 'features/Applications/screens/saves/saves.dart';

class CandidateNavigationMenu extends StatelessWidget {
  const CandidateNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
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
              const NavigationDestination(icon: Icon(Iconsax.document_text5, color: Colors.orangeAccent) , label:"Application"),
              const NavigationDestination(icon: Icon(Iconsax.save_21, color: Colors.yellow) , label:"Saved"),
              const NavigationDestination(icon: Icon(Iconsax.profile_circle5, color: Colors.purpleAccent) , label:"Profile"),
            ]
        ),
      ),
      body: Obx(() =>  controller.screens[controller.selectedIndex.value]),
    );
  }

}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [ const HomeScreen(), /*Container(color: Colors.greenAccent)*/ const ChatsScreen(), const Application(), const SavedScreen(), const SettingScreen()];
}
