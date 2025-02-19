import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class JSectionHeading extends StatelessWidget {
  const JSectionHeading({
    super.key,
    this.textColor,
    this.showActonButton = true,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
    this.alignment = MainAxisAlignment.spaceBetween,
    this.TextSize,
  });

  final Color? textColor;
  final bool showActonButton;
  final String title, buttonTitle;
  final void Function()? onPressed;
  final MainAxisAlignment alignment;
  final double? TextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Text(title,
            style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor).copyWith(fontSize: TextSize),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        const SizedBox(width: JSizes.spaceBtwItems),
        if (showActonButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}

