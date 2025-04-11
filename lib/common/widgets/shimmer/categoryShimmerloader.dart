import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/shimerEffect.dart';

class JCategoryShimmer extends StatelessWidget {
  const JCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: JSizes.spaceBtwItems,),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Image
              JShimmerEffect(width: 55, height: 55, radius: 55,),
              SizedBox(height: JSizes.spaceBtwItems / 2,),

              ///Text
              JShimmerEffect(width: 55, height: 8)
            ],
          );
        }


      ),
    );

  }
}
