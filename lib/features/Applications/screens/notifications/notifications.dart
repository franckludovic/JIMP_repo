import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/notifications/widget/notification_card.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final dark = JHelperFunctions.isDarkMode(context);
    
    return Scaffold(
      appBar: JAppbar(
        title: Text("Notifications", style: TextStyle(fontFamily: "Poppins", fontSize: 25, color: dark ? JColors.primary : JColors.black)),
        leadingIcon: Iconsax.arrow_left_3,
        leadingOnPressed:() => Get.back(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
            child: Column(
              children: [
                JSingleNotificationCard(unreadNew: true,),
                JSingleNotificationCard(unreadNew: false),
              ],
            ),

        ),
      ),
      
      
    );
  }
}
