import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class JGridLayout extends StatelessWidget {
  const JGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtend = 300,
    required this.itemBuilder,
  });


  final int itemCount;
  final double? mainAxisExtend;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: JSizes.gridViewSpacing,
        crossAxisSpacing: JSizes.gridViewSpacing,
        mainAxisExtent: mainAxisExtend,
      ),
      itemBuilder: itemBuilder ,

    );
  }
}
