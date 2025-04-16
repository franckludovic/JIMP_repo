import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../features/Applications/controllers/favorite controller.dart';
import '../../../utils/constants/colors.dart';

class JSaveIcon extends StatelessWidget {
  const JSaveIcon({
    super.key, required this.postingId,
  });
  
  final String postingId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Obx(() => IconButton(
        icon: controller.isFavorite(postingId) ? Icon(Icons.bookmark, color: JColors.primary, size: 25,) : Icon(Icons.bookmark_border_rounded, color: JColors.primary, size: 25,),
        onPressed: () => controller.toggleFavoritePosting(postingId),
        padding: EdgeInsets.zero,
        iconSize: 20,
      ),
    );
  }
}
