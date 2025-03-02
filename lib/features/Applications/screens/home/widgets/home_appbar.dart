import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return JAppbar(
      title: Row(
        children: [
          /// Clicking Profile Image Opens Drawer
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Open Drawer
            },
            child: SizedBox(
              width: 60,
              height: 60,
              child: JRoundedImage(
                imageUrl: JImages.user3,
                height: 60,
                width: 60,
              ),
            ),
          ),
          SizedBox(width: JSizes.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                JTexts.homeAppbarTitle,
                style: Theme.of(context).textTheme.labelMedium!.apply(color: JColors.grey),
              ),
              Text(
                JTexts.homeAppbarSubTitle,
                style: Theme.of(context).textTheme.headlineSmall!.apply(color: JColors.white),
              ),
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
