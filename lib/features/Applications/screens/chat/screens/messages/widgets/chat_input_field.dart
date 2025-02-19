import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../../../../utils/constants/sizes.dart';


class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: JSizes.defaultSpace,
        vertical: JSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            const Icon(Icons.mic, color: JColors.primary),
            const SizedBox(width: JSizes.defaultSpace),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: JSizes.defaultSpace * 0.75,
                ),
                decoration: BoxDecoration(
                  color: JColors.primary.withAlpha((0.05 * 255).toInt()),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha((0.64 * 255).toInt()),
                    ),
                    const SizedBox(width: JSizes.defaultSpace / 4),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha((0.64 * 255).toInt()),
                    ),
                    const SizedBox(width: JSizes.defaultSpace / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha((0.64 * 255).toInt()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
