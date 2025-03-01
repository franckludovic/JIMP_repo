import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';


class CompanyHomeHeader extends StatelessWidget {
  const CompanyHomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  image: AssetImage(JImages.googleProfileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: JRoundedContainer(
                padding: EdgeInsets.symmetric(horizontal: JSizes.md),
                backgroundColor:
                JColors.primary.withAlpha((0.6 * 255).toInt()),
                margin: EdgeInsets.only(
                    top: JSizes.defaultSpace * 1.8,
                    left: JSizes.defaultSpace,
                    right: JSizes.defaultSpace),
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Google", style: Theme.of(context).textTheme.headlineLarge,),
                        NotificationCounterIcon(onPressed: () {})

                      ],
                    )
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: JRoundedContainer(
                backgroundColor: JColors.darkGrey,
                height: 100,
                width: 100,
                radius: 100,
                child: JRoundedImage(imageUrl: JImages.google),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
