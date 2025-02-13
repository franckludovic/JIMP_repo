import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/application_reviews/widgets/rating_progess_indicator.dart';
import 'package:project_bc_tuto/features/Applications/screens/application_reviews/widgets/user_review_card.dart';

import '../../../../common/widgets/rating/Rating.dart';
import '../../../../utils/constants/sizes.dart';


class ApplicationReviewScreen extends StatelessWidget {
  const ApplicationReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding
          (padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Ratings and reviews are verified and are from people who use the same type of device as you use"),
              SizedBox(height: JSizes.defaultSpace),

              /// Overall product ratings
              const JOverallRatingIndicator(),
              JRatingBarIndicator(rating: 3.5),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall,),
              SizedBox(height: JSizes.spaceBtwSections,),


              ///user review List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}


