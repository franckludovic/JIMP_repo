import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/texts/applications_title_text.dart';

class CompanyRatingSubTitle extends StatelessWidget {
  const CompanyRatingSubTitle({
    super.key,
    required this.companyName,
    required this.rating,
     required this.country,
     required this.region,
     required this.town,
     required this.quater,
  });


    final String companyName;
    final String rating;
    final String country;
    final String region;
    final String town;
    final String quater;


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              JApplicationTitleText(title: companyName,textSize: 35),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(Iconsax.location, color: dark ? JColors.grey : JColors.darkGrey,),
                  SizedBox(width: JSizes.spaceBtwItems / 2,),

                  SizedBox(
                    width: 280,
                    child: Flexible(
                      child: Text(
                        "$quater, $town, $region, $country",
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Column(
            children: [
              Icon(Iconsax.star1, color: Colors.yellow, size: 45,),
              Text(rating, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),

        ],
      ),
    );
  }
}

