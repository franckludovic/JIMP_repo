import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/shimerEffect.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class JVerticalPostingShimmer extends StatelessWidget {
  const JVerticalPostingShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return JGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JShimmerEffect(width: 180, height: 180),
              SizedBox(height: JSizes.spaceBtwItems,),

              JShimmerEffect(width: 160, height: 15),
              SizedBox(height: JSizes.spaceBtwItems / 2),
              JShimmerEffect(width: 110, height: 15)
            ],
          ),
        )
    );
  }
}
