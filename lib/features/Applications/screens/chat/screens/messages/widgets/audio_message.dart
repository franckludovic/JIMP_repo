import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../../../../utils/constants/sizes.dart';

import 'package:flutter/material.dart';

import '../../../wigets/chat_message.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage? message;

  const AudioMessage({super.key, this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(
        horizontal: JSizes.defaultSpace * 0.75,
        vertical: JSizes.defaultSpace / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color:message!.isSender ? JColors.primary.withAlpha((255)) : JColors.primary.withAlpha((255 * 0.1).toInt()),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message!.isSender ? Colors.white : JColors.primary,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: JSizes.defaultSpace / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message!.isSender
                        ? Colors.white
                        : JColors.primary.withAlpha((0.4 * 255).toInt()),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message!.isSender ? Colors.white : JColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12, color: message!.isSender ? Colors.white : null),
          ),
        ],
      ),
    );
  }
}
