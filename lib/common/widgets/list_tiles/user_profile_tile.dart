import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../Images/Jcircular_image.dart';

class JUserProfileTile extends StatelessWidget {
  const JUserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: JCircularImage(
        image: JImages.user3,
        width: 50,
        height: 50,
        padding: 0,

      ),
      title: Text('Metatron', style: Theme.of(context).textTheme.headlineMedium!.apply(color: JColors.white)),
      subtitle: Text('Metatron@gmail.com', style: Theme.of(context).textTheme.bodyMedium!.apply(color: JColors.white)),
      trailing: IconButton(onPressed: () {}, icon: Icon(Iconsax.edit, color: JColors.white)),
    );
  }
}
