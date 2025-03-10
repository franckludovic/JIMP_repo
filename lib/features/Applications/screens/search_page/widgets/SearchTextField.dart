import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,  this.isFilter = false,

  });

  final bool isFilter;


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(
          flex: 10,
          child: Container(
            padding: EdgeInsets.only(left: JSizes.md),
            height: 50,
            decoration: BoxDecoration(
              border: Border.all( color: dark ? JColors.grey : JColors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(5),
              ),
              color: Colors.transparent,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Type to search",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),

        SizedBox(width: 5,),
        Flexible(
            flex: 2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: JColors.white),
                color: dark ? JColors.white : JColors.grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: IconButton(onPressed:() {}, icon: Icon( isFilter?  Icons.filter_alt_rounded : Icons.search_rounded, color: JColors.secondary ,size: 30,)),
            )
        ),
      ],
    );
  }
}
