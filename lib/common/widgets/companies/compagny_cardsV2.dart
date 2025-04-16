import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../Images/Jcircular_image.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../shimmer/shimerEffect.dart';
import '../texts/compagny_title_with_verified_icon.dart';


class JCompagnyCard2 extends StatelessWidget {
  const JCompagnyCard2({
    super.key,
    required this.showBorder,
    this.onTap, required this.company,
  });

  final CompanyModel company;

  final bool showBorder;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyController());
    return GestureDetector(
      onTap: onTap,
      child: JRoundedContainer(
        padding: const EdgeInsets.all(JSizes.xs),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///icon
            Flexible(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
                ),
                margin: EdgeInsets.only(right: JSizes.md),
                //padding: const EdgeInsets.all(JSizes.sm),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:company.logoUrl ,
                      progressIndicatorBuilder: (context, url, downloadProgress) => const JShimmerEffect(width: 55, height: 55, radius: 55,),
                      errorWidget: (context, url, error) =>const Icon(Icons.business_rounded, color: JColors.primary, size: 40,),
                    )
                ),

              )),


             SizedBox(height: JSizes.spaceBtwItems / 2),

            /// --text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JCompagnyTittleVerifications(
                      title: company.fullName, compagnyTextSize: TextSizes.large),
                  Text(
                    '${company.totalListings} applications',
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
