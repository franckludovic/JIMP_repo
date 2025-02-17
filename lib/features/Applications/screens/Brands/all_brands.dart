import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/companies/compagny_cards.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/Brands/brand_product.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/companies/compagny_cardsV2.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JAppbar(title: Text('Brands',), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///--Headings
              const JSectionHeading(title: "Brands", showActonButton: false,),
              const SizedBox(height: JSizes.spaceBtwItems,),

              ///--Brands
              JGridLayout(itemCount: 10, mainAxisExtend: 80, itemBuilder: (context, index) => JCompagnyCard2(showBorder: true, onTap: () => Get.to(() => const BrandProduct()),))
              
            ],
          ),
        ),
      ),
    );
  }
}
