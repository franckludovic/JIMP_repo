import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SearchFieldSubHead extends StatelessWidget {
  const SearchFieldSubHead({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Results', style: Theme.of(context).textTheme.headlineMedium,),
              Text('45 Internship founded', style: TextStyle(fontSize: 15, color: dark ? JColors.darkGrey : JColors.darkerGrey))
            ],
          ),

          IconButton(onPressed: () {}, icon: Icon(Iconsax.candle, size: 30, color: dark ? JColors.white : JColors.black,))

        ],
      ),
    );
  }
}

