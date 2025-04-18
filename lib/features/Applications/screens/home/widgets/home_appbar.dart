import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/shimerEffect.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return JAppbar(
      title: Row(
        children: [
          /// Clicking Profile Image Opens Drawer
          GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Open Drawer
              },
              child: SizedBox(
                width: 57,
                height: 57,
                child: Obx(() {
                  if (controller.profileLoading.value) {
                    return const JShimmerEffect(width: 60, height: 60);
                  } else {
                    return JRoundedImage(
                      isNetworkImage: true,
                      imageUrl: controller.user?.profilePicture ?? '',
                      width: 60,
                      borderRadius: 60,
                      applyImageRadius: true,
                    );
                  }
                }),
              )
          ),
          SizedBox(width: JSizes.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JTexts.homeAppbarTitle,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: JColors.grey),
              ),
              Obx(() {
                if (controller.profileLoading.value) {
                  return const JShimmerEffect(width: 80, height: 15);
                } else {
                  return Text(
                    controller.user?.fullName ?? 'Guest',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .apply(color: JColors.white),
                  );
                }
              }),
            ],
          ),
        ],
      ),
      actions: [
        NotificationCounterIcon(onPressed: () {}, iconColor: JColors.white),
      ],
    );
  }
}
