import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

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
      leading: JRoundedImage(
        isNetworkImage: true,
        imageUrl: controller.user?.profilePicture ?? '',
        width: 55,
        borderRadius: 55,
        applyImageRadius: true,
      ),

      title: Text(softWrap: true , maxLines: 1, overflow: TextOverflow.ellipsis, controller.user?.fullName ?? 'Guest', style: Theme.of(context).textTheme.headlineMedium!.apply(color: JColors.white)),
      subtitle: Text(softWrap: true , maxLines: 1, overflow: TextOverflow.ellipsis, controller.user?.email ?? '', style: Theme.of(context).textTheme.bodyMedium!.apply(color: JColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: Icon(Iconsax.edit, color: JColors.white)),
    );
  }
}
