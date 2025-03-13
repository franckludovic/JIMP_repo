import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/sizes.dart';

class InfoTile extends StatelessWidget {
  const  InfoTile({
    super.key,
    required this.textBody,
    required this.title,
    this.spacing = JSizes.spaceBtwItems / 2,
    this.numberLines = 3,
    this.textBodySize = 15,
    this.titleSize,
    this.TextColor,
    this.titleColor,  this.isEditable = false,
  });

  final String textBody;
  final String title;
  final double spacing;
  final int numberLines;
  final double textBodySize;
  final double? titleSize;
  final Color? TextColor;
  final Color? titleColor;
  final bool isEditable;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: titleSize, color: titleColor ) ),

                  isEditable ? Icon(Icons.edit) : Text("")
                
                ],
              ),
            ),
            SizedBox(height: spacing),
            ReadMoreText(
              textBody,
              style: TextStyle(fontSize: textBodySize, color:  TextColor ),
              trimLines: numberLines,
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
