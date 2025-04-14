import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/search_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/data/repositories/postings/posting_repository.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';


import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/compamy_screens/login/login_company.dart';
import '../../controllers/posting_controller.dart';
import '../all_jobs/all_application.dart';
import 'Widgets/postings.dart';
import 'Widgets/companycategory.dart';


class CompanyApplicationScreen extends StatelessWidget {
  const CompanyApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final PostingController controller = Get.put(PostingController());
    final PostingRepository postingRepository = Get.put(PostingRepository());


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
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: JHelperFunctions.isDarkMode(context)
                        ? JColors.black
                        : JColors.white,
                    expandedHeight: 700,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.all(JSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          /// Search bar and content
                          SizedBox(height: JSizes.spaceBtwItems),
                          JSearchContainer(
                            text: 'Search for a Posting',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(height: JSizes.spaceBtwSections),

                          /// Content that scrolls
                          Column(
                            children: [
                              JSectionHeading(
                                title: 'Latest Postings',
                                onPressed: () => Get.to(() => AllPostings()),
                              ),
                              SizedBox(height: JSizes.spaceBtwItems * 0.7),
                              Obx(() {
                                // Use the length of posts for the grid
                                return JGridLayout(
                                  itemCount: controller.companyPosts.length,
                                  mainAxisExtend: 250,
                                  crossAxisCount: 1,
                                  itemBuilder: (_, index) {
                                    final posting = controller.companyPosts[index];
                                    return JobPostCard(
                                      posting: posting,
                                    );
                                  },
                                );
                              }),
                              SizedBox(height: JSizes.spaceBtwSections),
                            ],
                          ),
                        ],
                      ),
                    ),
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
              body: TabBarView( children: [JCompanyCategory(), JCompanyCategory(), JCompanyCategory(), JCompanyCategory(), JCompanyCategory(), JCompanyCategory(),]
              ),
            ),

          ],
        ),
        floatingActionButton: FloatingActionButton(
            //onPressed: () => Get.to(() => JobCreationPage()),
            onPressed: () => Get.to(() => CompagnyLoginScreen()),
            backgroundColor: JColors.primary,
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            )
        ),
      ),
    );
  }
}