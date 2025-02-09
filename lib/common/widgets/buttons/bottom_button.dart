import 'package:flutter/material.dart';


class Jbutton extends StatelessWidget {
  const Jbutton({
    super.key,
    required this.buttonTitle,
    this.textColor,
    required this.borderRadius,
    this.backgroundColor = Colors.blueAccent,
    required this.padding,
  });

  final String buttonTitle;
  final Color? textColor;
  final double borderRadius;
  final Color? backgroundColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            padding: EdgeInsets.all(padding),

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)
            )
        ),
        onPressed: () {},
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
        ));
  }
}
