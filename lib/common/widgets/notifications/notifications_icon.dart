import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/Applications/screens/notifications/notifications.dart';
import '../../../utils/constants/colors.dart';


class NotificationCounterIcon extends StatelessWidget {
  const NotificationCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: ()  => Get.to(() => const JNotificationScreen()), icon: Icon(Iconsax.notification, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: JColors.black.withAlpha((0.5 * 255).toInt()),
              borderRadius: BorderRadius.circular(100),
            ) ,
            child: Center(
              child: Text("10", style: Theme.of(context).textTheme.labelLarge!.apply(color: JColors.white, fontSizeFactor: 0.8)),
            ),
          ),
        )
      ],
    );
  }
}
