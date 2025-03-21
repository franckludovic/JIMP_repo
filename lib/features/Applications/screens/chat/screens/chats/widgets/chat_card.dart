import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../../../../utils/constants/sizes.dart';
import '../../../wigets//chat.dart';
import 'package:flutter/material.dart';


class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.chat,
    required this.press,
  });

  final Chat chat;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: JColors.black,

      child: InkWell(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: JSizes.defaultSpace, vertical: JSizes.defaultSpace * 0.75),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(chat.image),
                  ),
                  if (chat.isActive)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: JColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3),
                        ),
                      ),
                    )
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: JSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Opacity(
                        opacity: 0.64,
                        child: Text(
                          chat.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Opacity(
                opacity: 0.64,
                child: Text(chat.time),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
