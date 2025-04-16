import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/scrollable_container/category_scrolable.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/controllers/category_controller.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications/Widgets/category.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';

import '../../../../common/widgets/job_and_internship_card/final_vertical_postings_card.dart';
import '../../../../common/widgets/job_and_internship_card/vertical_Application.dart';

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
import '../../controllers/posting_controller.dart';
import '../Brands/all_brands.dart';
import '../Brands/brand_product.dart';
import '../all_product/all_application.dart';
import '../search_page/search_body.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final PostingController postingController = Get.put(PostingController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length,
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
                        GestureDetector(
                          onTap: () => Get.to(() => const SearchBody()),
                          child: JSearchContainer(
                              text: 'Search in Hub',
                              showBorder: true,
                              showBackground: false,
                              padding: EdgeInsets.zero),
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),

                        ///--feature companies
                        JSectionHeading(
                            title: 'Feature Companies',
                            showActonButton: true,
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen())),
                        const SizedBox(height: JSizes.spaceBtwItems / 1.5),

                        ///compagnies grid

                        Column(
                          children: [
                            Obx(() {
                              final CompanyController companyController = Get.put(CompanyController());
                              final company = companyController.company;
                              final latestCompany = company.length >= 4 ? company.sublist(0, 4) : company;
                              return JGridLayout(
                                  itemCount: latestCompany.length,
                                  mainAxisExtend: 80,
                                  itemBuilder: (_, index) {
                                   final companies = latestCompany[index];
                                    return JCompagnyCard2(
                                      company:companies,
                                      showBorder: true,
                                      onTap: () => Get.to(() =>  BrandProduct(company: companies)),
                                    );
                                  });


                            }),

                            SizedBox(
                              height: JSizes.spaceBtwSections * 0.7,
                            ),

                            //Divider(thickness: 5 ),
                            JDivider(),

                            JSectionHeading(
                                title: 'Popular Internships',
                                onPressed: () =>
                                    Get.to(() => AllApplications())),

                            SizedBox(
                              height: JSizes.spaceBtwItems * 0.7,
                            ),


                            Obx(() {

                              final posts = postingController.posts;
                              final latestPosting = posts.length >= 5 ? posts.sublist(0, 5) : posts;
                              return JGridLayout(
                                  itemCount: latestPosting.length,
                                  crossAxisCount: 2,
                                  itemBuilder: (_, index) {
                                    final posting = latestPosting[index];
                                    return VerticalPostingCard(
                                      posting: posting,
                                    );
                                  }
                              );
                              },
                            ),

                            SizedBox(
                              height: JSizes.spaceBtwSections,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  ///tabs
                  bottom: JTabBar(
                      tabs: categories
                          .map((category) => Tab(child: Text(category.name)))
                          .toList()),
                ),
              ];
            },
            body: TabBarView(
                children: categories
                    .map((category) => JCategoryTab(category: category))
                    .toList())),
      ),
    );
  }
}
