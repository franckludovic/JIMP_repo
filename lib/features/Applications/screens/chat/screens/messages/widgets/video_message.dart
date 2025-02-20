import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';

import '../../../../../../../utils/constants/colors.dart';
import '../../../../../../../utils/constants/image_strings.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: JDeviceUtils.getScreenWidth(context) * 0.45,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(JImages.googleProfileImage),
            ),
            Container(
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: JColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 16,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
