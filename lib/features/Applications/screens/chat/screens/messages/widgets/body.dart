import 'package:flutter/material.dart';

import '../../../../../../../utils/constants/sizes.dart';

import '../../../wigets/chat_message.dart';
import 'chat_input_field.dart';
import 'message.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: JSizes.defaultSpace),
            child: ListView.builder(
              itemCount: demeChatMessages.length,
              itemBuilder: (context, index) =>
                  Message(message: demeChatMessages[index]),
            ),
          ),
        ),
        const ChatInputField(),
      ],
    );
  }
}
