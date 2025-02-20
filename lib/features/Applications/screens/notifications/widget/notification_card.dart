import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';

class JSingleNotificationCard extends StatelessWidget {
  const JSingleNotificationCard({super.key, required this.unreadNew});

  final bool unreadNew;

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return JRoundedContainer(
      padding: EdgeInsets.all(JSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: unreadNew ? JColors.primary.withAlpha((0.5 * 255).toInt()) : Colors.transparent,

      borderColor: unreadNew ? Colors.transparent : dark ? JColors.darkerGrey : JColors.grey,

      margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Apply Success",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: JSizes.sm/2,),
          const Text('Queenify HR',style: TextStyle(color: JColors.darkerGrey), maxLines: 1, overflow: TextOverflow.ellipsis,),
          const SizedBox(height: JSizes.sm/2,),
          const Text("You has apply an job in Queenify Group as UI Designer", softWrap: true),

          SizedBox(height: JSizes.xs),

          if(unreadNew)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(width: JSizes.xs),
                  Text('10h ago'),
                ],
              ),

              TextButton(onPressed: () {}, child: Text("Mark as read")),

            ],
          ),

          if(!unreadNew)
            Container(
              margin: EdgeInsets.only(top: JSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      Icon(Icons.access_time_rounded),
                      SizedBox(width: JSizes.xs),
                      Text('10h ago'),
                    ],
                  ),

                  Icon(Iconsax.tick_circle, color: JColors.primary,) ,

                ],
              ),
            ),

        ],
      ),

    );
  }
}

