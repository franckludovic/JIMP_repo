import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/Brands/brand_product.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/companies/compagny_cardsV2.dart';
import '../../../personilization/controllers/company_controller.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const JAppbar(
            title: Text(
              'Brands',
            ),
            showBackArrow: true),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(children: [
            ///--Headings
            const JSectionHeading(
              title: "Brands",
              showActonButton: false,
            ),
            const SizedBox(
              height: JSizes.spaceBtwItems,
            ),

            ///--Brands
            Column(
              children: [
                Obx(() {
                  final CompanyController companyController = Get.put(CompanyController());
                  final company = companyController.company;
                  return JGridLayout(
                      itemCount: company.length,
                      mainAxisExtend: 80,
                      itemBuilder: (_, index) {
                        final companies = company[index];
                        return JCompagnyCard2(
                          company: companies,
                          showBorder: true,
                          onTap: () => Get.to(() =>  BrandProduct(company: companies,)),
                        );
                      });
                }),
              ],
            ),
          ]),
        )));
  }
}
