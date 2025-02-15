import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/sizes.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.textBody,
    required this.title
  });

  final String textBody;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JSizes.md),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(title, style: Theme.of(context).textTheme.headlineMedium ),
            ),
            SizedBox(height: JSizes.spaceBtwItems / 2),
            ReadMoreText(
              textBody,
              style: TextStyle(fontSize: 15),
              trimLines: 3,
              trimMode: TrimMode.Line,
              trimCollapsedText: " Show more",
              trimExpandedText: "  Show Less",
              moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),

          ],
        ),

      ),
    );
  }
}
