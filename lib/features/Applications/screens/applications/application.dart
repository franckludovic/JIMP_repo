import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications/Widgets/category.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/companies/compagny_cards.dart';
import '../../../../common/widgets/layout/application_grid_layout.dart';
import '../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

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
                            onPressed: () {}),
                        const SizedBox(height: JSizes.spaceBtwItems / 1.5),

                        ///compagnies grid
                        JIGridLaout(
                          aspectRatio: 2,
                          JList: [
                            JCompagnyCard(title: "Google", num_Applications: 55,image: JImages.google,),
                            JCompagnyCard(title: "Nvidia", num_Applications: 108,image: JImages.nvidia,),
                            JCompagnyCard(title: "APPlE", num_Applications: 65,image: JImages.apple,),
                            JCompagnyCard(title: "Facebook", num_Applications: 78,image: JImages.facebook,),
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
            body: TabBarView(children: [JCategory(), JCategory(), JCategory(), JCategory(), JCategory(), JCategory(),]
            )
        ),
      ),
    );
  }
}
