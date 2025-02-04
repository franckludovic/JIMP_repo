import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/enums.dart';

class JCompagnyTitleText extends StatelessWidget {
  const JCompagnyTitleText({super.key,
    this.color,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.compagnyTextSize = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes compagnyTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //check which compagnysize is required and set th style
      style: compagnyTextSize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : compagnyTextSize == TextSizes.medium
            ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
            :compagnyTextSize == TextSizes.large
              ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
              : Theme.of(context).textTheme.bodyMedium!.apply(color: color)

    );
  }
}
