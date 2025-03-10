import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import 'chatscreen.dart';

class IndividualChatsScreen extends StatelessWidget {
  const IndividualChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual chat channels (ListTile widgets)
    return Padding(
      padding: const EdgeInsets.all(JSizes.md),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return JRoundedContainer(
            height: 90,
            backgroundColor: Colors.blue.shade50,
            padding: EdgeInsets.symmetric(vertical: JSizes.sm),
            margin: EdgeInsets.symmetric(vertical: JSizes.xs),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30,
                child: Icon(Icons.person),
              ),
              title: Text(
                "Chat with Candidate ${index + 1}",
                style: TextStyle(color: JColors.black),
              ),
              subtitle: const Text(
                "Last message preview...",
                style: TextStyle(color: JColors.black),
              ),
              onTap: () {
                // Navigate to the individual chat screen
                Get.to(() => const ChatScreen(isGroupChat: false));
              },
            ),
          );
        },
      ),
    );
  }
}
