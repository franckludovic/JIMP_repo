import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications/Widgets/category.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/companies/compagny_cards.dart';
import '../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../Brands/all_brands.dart';

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
                  expandedHeight: 430,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(JSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
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
                            onPressed: () => Get.to(() => const AllBrandsScreen())),
                        const SizedBox(height: JSizes.spaceBtwItems / 1.5),

                        ///compagnies grid
                        JGridLayout(
                            itemCount: 4,
                            mainAxisExtend: 80,
                            itemBuilder: (_, index) {
                              return JCompagnyCard(showBorder: true);
                            })
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
            body: TabBarView(children: [JCategory(), JCategory(), JCategory(), JCategory(), JCategory(), JCategory(),]
            )
        ),
      ),
    );
  }
}
