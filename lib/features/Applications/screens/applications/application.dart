import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications/Widgets/category.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';


import '../../../../common/widgets/applications/applications_cards/vertical_Application.dart';
///import 'package:project_bc_tuto/utils/constants/image_strings.dart';
///import '../../../../common/widgets/companies/compagny_cards.dart';
///import '../../../../common/widgets/layout/application_grid_layout.dart';


import '../../../../common/widgets/companies/compagny_cardsV2.dart';
import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../Brands/all_brands.dart';
import '../Brands/brand_product.dart';
import '../all_product/all_application.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: JAppbar(
          title: Text('Applications',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            NotificationCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: JHelperFunctions.isDarkMode(context)
                      ? JColors.black
                      : JColors.white,
                  expandedHeight: 685,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(JSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ///Searh bar
                        SizedBox(height: JSizes.spaceBtwItems),
                        JSearchContainer(
                            text: 'Search in Hub',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero),
                        const SizedBox(height: JSizes.spaceBtwSections),

                        ///--feature companies
                        JSectionHeading(
                            title: 'Feature Companies',
                            showActonButton: true,
                            onPressed: ()  => Get.to(() => const AllBrandsScreen())),
                        const SizedBox(height: JSizes.spaceBtwItems / 1.5),

                        ///compagnies grid

                        Column(
                          children: [
                            JGridLayout(
                                itemCount: 4,
                                mainAxisExtend: 80,
                                itemBuilder: (_, index) {
                                  return JCompagnyCard2(showBorder: true, onTap: () => Get.to(() => const BrandProduct()),);
                                }
                            ),

                            SizedBox(height: JSizes.spaceBtwSections * 0.7 ,),

                            //Divider(thickness: 5 ),
                            JDivider(),


                            JSectionHeading(title: 'Popular Internships', onPressed: () => Get.to(() => AllApplications())),

                            SizedBox(height: JSizes.spaceBtwItems * 0.7,),

                            JGridLayout(itemCount: 14,crossAxisCount: 2, itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', )),

                            SizedBox(height: JSizes.spaceBtwSections,),
                          ],
                        )
                      ],
                    ),
                  ),



                  ///tabs
                  bottom: const JTabBar(
                    tabs: [
                      Tab(child: Text("Data Analyst")),
                      Tab(child: Text("Designer")),
                      Tab(child: Text("Mechanic")),
                      Tab(child: Text("Accountant")),
                      Tab(child: Text("DB Administrator")),
                      Tab(child: Text("Network Administrator")),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView( children: [JCategory(), JCategory(), JCategory(), JCategory(), JCategory(), JCategory(),]
            )
        ),
      ),
    );
  }
}

