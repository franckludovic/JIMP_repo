import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return JAppbar(title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TTexts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: JColors.grey)),
        Text(TTexts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: JColors.white)),
      ],
    ),
      actions: [
        NotificationCounterIcon(onPressed: () {}, iconColor: JColors.white),
      ],
    );
  }
}