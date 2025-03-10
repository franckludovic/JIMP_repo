import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import 'chatscreen.dart';

class GroupChatsScreen extends StatelessWidget {
  const GroupChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(JSizes.md),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return JRoundedContainer(
            height: 90,
            backgroundColor: Colors.purple.shade50,
            padding: EdgeInsets.symmetric(vertical: JSizes.sm),
            margin: EdgeInsets.symmetric(vertical: JSizes.xs),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.group),
              ),
              title: Text(
                "Group Chat ${index + 1}",
                style: TextStyle(color: JColors.black),
              ),
              subtitle: const Text(
                "Team conversation preview...",
                style: TextStyle(color: JColors.black),
              ),
              onTap: () {
                // Navigate to the group chat screen
                Get.to(() => const ChatScreen(isGroupChat: true));
              },
            ),
          );
        },
      ),
    );
  }
}
