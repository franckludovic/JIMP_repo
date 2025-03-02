import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import '../../notifications/notifications.dart';

class JSidebar extends StatelessWidget {
  final SidebarXController controller;

  const JSidebar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SidebarX(

      controller: controller,

      theme: SidebarXTheme(
        width: controller.extended ? 200 : 60,
        selectedIconTheme: IconThemeData(size: 35),
        decoration: BoxDecoration(color: JColors.black),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        textStyle: const TextStyle(color: Colors.white),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
      ),
      items: [
        SidebarXItem(icon: Icons.home, label: 'Home',),
        SidebarXItem(icon: Icons.search, label: 'Search',),
        SidebarXItem(icon: Icons.notifications, label: 'Notifications', onTap: () => Get.to(() => const JNotificationScreen())),
      ],
    );
  }
}
