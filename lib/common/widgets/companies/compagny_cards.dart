import 'package:flutter/material.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../Images/Jcircular_image.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../texts/compagny_title_with_verified_icon.dart';


class JCompagnyCard extends StatelessWidget {
  const JCompagnyCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.title,
    required this.num_Applications,
    required this.image,
  });

  final bool showBorder;
  final String image;
  final void Function()? onTap;
  final String title;
  final int num_Applications;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: JRoundedContainer(
        padding: const EdgeInsets.all(JSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///icon
            Flexible(
              child: JCircularImage(
                isNetworkImage: false,
                image: image,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwItems / 2),

            /// --text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JCompagnyTittleVerifications(
                      title: title, compagnyTextSize: TextSizes.large),
                  Text(
                    "$num_Applications applications",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
