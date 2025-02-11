import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

class TimeFrame extends StatelessWidget {
  const TimeFrame({
    super.key,
    required this.timeFrame
  });

  final String timeFrame;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Period: ", style: Theme.of(context).textTheme.headlineMedium!.apply(color: JColors.darkGrey)),
        Text(timeFrame, style: Theme.of(context).textTheme.headlineMedium,)
      ],
    );
  }
}
