import 'package:flutter/material.dart';

class ApplicationTitleText extends StatelessWidget {
  const ApplicationTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: (smallSize
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.titleSmall)
            ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold), // Merge styles
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
