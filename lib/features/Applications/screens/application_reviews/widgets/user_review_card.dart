import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/rating/Rating.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
               const CircleAvatar(backgroundImage: AssetImage(JImages.userProfileImage1)),
                const SizedBox(width: JSizes.spaceBtwItems),
                Text("Jenny bright", style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: JSizes.spaceBtwItems,),
        
        
        ///Review
        Row(
          children: [
            JRatingBarIndicator(rating: 4),
            const SizedBox(width: JSizes.spaceBtwItems,),
            Text("01 Nov 2023", style: Theme.of(context).textTheme.bodyMedium,)
          ],
        ),
        const SizedBox(height: JSizes.spaceBtwItems,),
        ReadMoreText(
          'Since Ihave specific information about that brand, let focus on general troubleshooting steps that are likely to help, based on your previous message that you everything.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: " Show Less",
          trimCollapsedText: " Show More",
          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: JColors.primary),
          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: JColors.primary),
        ),
        const SizedBox(height: JSizes.spaceBtwItems),


        ///company review
        JRoundedContainer(
          backgroundColor: dark ? JColors.darkerGrey : JColors.grey,
          child: Padding(
            padding: EdgeInsets.all(JSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("JIMP", style: Theme.of(context).textTheme.titleMedium),
                    Text("02 Nov 2023", style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwItems,),
                ReadMoreText(
                  'Since Ihave specific information about that brand, let focus on general troubleshooting steps that are likely to help, based on your previous message that you everything.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: " Show Less",
                  trimCollapsedText: " Show More",
                  moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: JColors.primary),
                  lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: JColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: JSizes.spaceBtwSections,),

      ],
    );
  }
}
