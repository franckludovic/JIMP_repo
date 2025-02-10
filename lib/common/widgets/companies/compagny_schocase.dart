import 'package:flutter/material.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';

class JCompagnyShowCase extends StatelessWidget {
  const JCompagnyShowCase({
    super.key,
    required this.jobs,
  });

  final List<Widget> jobs;

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      //showBorder: true,
      //borderColor: JColors.darkerGrey,
      //padding: const EdgeInsets.all(JSizes.xs),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < jobs.length; i++) ...[
            SizedBox(
              width: double.infinity, // Ensures full width
              child: jobs[i],
            ),
            if (i != jobs.length - 1) const SizedBox(height: 16),
          ],
        ],
      )

    );
  }
}
