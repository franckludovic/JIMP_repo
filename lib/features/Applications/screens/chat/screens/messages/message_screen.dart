import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat/screens/messages/widgets/body.dart';

import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';


class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const MessageBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage(JImages.user3),
          ),
          SizedBox(width: JSizes.defaultSpace * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kristin Watson",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        const SizedBox(width: JSizes.defaultSpace / 2),
      ],
    );
  }
}
