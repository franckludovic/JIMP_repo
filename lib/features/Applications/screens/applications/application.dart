import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/utils/constants/enums.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/Images/Jcircular_image.dart';
import '../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../common/widgets/texts/compagny_title_with_verified_icon.dart';
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
                        JGridLayout(
                            itemCount: 4,
                            mainAxisExtend: 80,
                            itemBuilder: (_, index) {
                              return JCompagnyCard();
                            })
                      ],
                    ),
                  ),

                  ///tabs
                  bottom:  TabBar(

                    isScrollable: true,
                    indicatorColor: JColors.primary,
                    unselectedLabelColor: JColors.darkGrey,
                    labelColor: JHelperFunctions.isDarkMode(context) ? JColors.white : JColors.primary,
                    tabs: [
                      Tab(child: Text("Data Analyst")),
                      Tab(child: Text("Designer")),
                      Tab(child: Text("Mechanic")),
                      Tab(child: Text("Accountant")),
                      Tab(child: Text("DB Administrator")),
                      Tab(child: Text("Network Administrator")),
                    ]
                  ),
                ),
              ];
            },
            body: Container()),
      ),
    );
  }
}

class JCompagnyCard extends StatelessWidget {
  const JCompagnyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: JRoundedContainer(
        padding: const EdgeInsets.all(JSizes.xs),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///icon
            Flexible(
              child: JCircularImage(
                isNetworkImage: false,
                image: JImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: JHelperFunctions.isDarkMode(context)
                    ? JColors.white
                    : JColors.black,
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwItems / 2),

            /// --text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JCompagnyTittleVerifications(
                      title: "CBC", compagnyTextSize: TextSizes.large),
                  Text(
                    '256 Applications',
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
