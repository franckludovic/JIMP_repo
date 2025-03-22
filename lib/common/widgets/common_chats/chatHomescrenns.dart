import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/common_chats/widgets/groupChats.dart';
import 'package:project_bc_tuto/common/widgets/common_chats/widgets/indivudualChart.dart';
import 'package:project_bc_tuto/common/widgets/common_chats/widgets/pinnedChats.dart';
import 'package:project_bc_tuto/common/widgets/texts/textArea.dart';

import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: JColors.primary,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Messages",
                    style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.white,
                      )
                  ),
                ],
              ),
              SizedBox(
                height: JSizes.md,
              ),
              JTextArea(
                backgroundcolor: JColors.grey,
                label: Text(
                  "Search for Discussions ",
                  style: TextStyle(color: JColors.darkerGrey),
                ),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 30,
                ),
              ),
              SizedBox(
                height: JSizes.sm,
              ),
            ],
          ),
          toolbarHeight: 120,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Individual"),
              Tab(text: "Group"),
              Tab(text: "Marked"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            IndividualChatsScreen(),
            GroupChatsScreen(),
            Marked(),
          ],
        ),

      ),
    );
  }
}
