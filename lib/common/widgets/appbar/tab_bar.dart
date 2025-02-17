import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class JTabBar extends StatelessWidget implements PreferredSizeWidget{
  const JTabBar({
    super.key, required this.tabs,
  });

  final List<Widget> tabs;
  
  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return Material(

      color: dark ? JColors.black : JColors.softGrey,

      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: JColors.primary,
        unselectedLabelColor: JColors.darkGrey,
        labelColor: JHelperFunctions.isDarkMode(context) ? JColors.white : JColors.black,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override

  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
}