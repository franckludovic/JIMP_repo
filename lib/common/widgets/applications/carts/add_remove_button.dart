import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class JApplied_drop_buttons extends StatelessWidget {
  const JApplied_drop_buttons({
    super.key,
    this.status = 'PENDING',
  });

  final String status;

  @override
  Widget build(BuildContext context) {
   final dark = JHelperFunctions.isDarkMode(context);
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal:  JSizes.lg, vertical: JSizes.sm)
        ),
        onPressed: () {},
        child: Text("Drop", style: Theme.of(context).textTheme.titleMedium!.apply(color:  dark ? JColors.white : JColors.black ),),
      ),
    );
  }
}
