import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../icons/circular_icon.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    super.key,
    required this.country,
    required this.town,
    required this.quater,
    required this.region,
  });

  final String country;
  final String region;
  final String town;
  final String quater;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        JCircularIcon(
          icon: Iconsax.location,
          size: 25,
          backgroundColor: JColors.darkGrey,
          width: 40,
          height: 40,
          color: JColors.white,
        ),
        SizedBox(width: JSizes.spaceBtwItems / 2),

        Expanded(
          child: Text(
            "$quater, $town, $region, $country",
            style: TextStyle(fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
