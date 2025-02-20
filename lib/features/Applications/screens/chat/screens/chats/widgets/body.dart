import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';
import '../../../wigets//chat.dart';
import '../../messages/message_screen.dart';
import 'package:flutter/material.dart';

import 'chat_card.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: JColors.black,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                0, JSizes.defaultSpace, 0, JSizes.defaultSpace / 2),
            color: JColors.primary,
            child:JSearchContainer(text: "Search for a message",),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsData.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chatsData[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MessagesScreen(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
