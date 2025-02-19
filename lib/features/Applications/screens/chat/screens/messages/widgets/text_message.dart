import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../../../../utils/constants/sizes.dart';

import '../../../wigets/chat_message.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    this.message,
  });

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MediaQuery.of(context).platformBrightness == Brightness.dark
      //     ? Colors.white
      //     : Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: JSizes.defaultSpace * 0.75,
        vertical: JSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: message!.isSender ? JColors.primary : JColors.secondary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message!.text,
        style: TextStyle(
          color: message!.isSender
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
    );
  }
}
