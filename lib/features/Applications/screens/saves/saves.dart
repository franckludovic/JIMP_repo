import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/icons/circular_icon.dart';
import 'package:project_bc_tuto/common/widgets/job_and_internship_card/final_vertical_postings_card.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/verticalShimmerLoader.dart';
import 'package:project_bc_tuto/features/Applications/controllers/favorite%20controller.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/cloud_helper_functions.dart';
import 'package:project_bc_tuto/utils/loaders/animation_loader.dart';

class SavesScreen extends StatelessWidget {
  const SavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    final PostingModel posting;


    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'Saves',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          JCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(CandidateNavigationMenu()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Obx( () => FutureBuilder(
              future: controller.favoritePostings(),
              builder: (context, snapshot) {

                final emptyWidget = TAnimationLoaderWidget(
                  text: 'Whoops! Saves is Empty, Saves is sap please fill Saves ',
                  animation: JImages.pencilAnimation,
                  showAction: true,
                  actionText: 'Let\'s fill lil Saves!!!',
                  onActionPressed: () => Get.offAll(const CandidateNavigationMenu()),
                );


                const loader = JVerticalPostingShimmer(itemCount: 6,);
                final widget = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader, nothingFound: emptyWidget);
                if(widget != null) return widget;

                final postings = snapshot.data!;
                return JGridLayout(
                    itemCount: postings.length,
                    itemBuilder: (_, index) => VerticalPostingCard(posting: postings[index]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
