import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../Images/Jcircular_image.dart';

class JUserProfileTile extends StatelessWidget {
  const JUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: JCircularImage(
        image: JImages.user3,
        width: 50,
        height: 50,
        padding: 0,

      ),
      title: Text(controller.user?.fullName ?? 'Guest', style: Theme.of(context).textTheme.headlineMedium!.apply(color: JColors.white)),
      subtitle: Text(controller.user?.email ?? '', style: Theme.of(context).textTheme.bodyMedium!.apply(color: JColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: Icon(Iconsax.edit, color: JColors.white)),
    );
  }
}
