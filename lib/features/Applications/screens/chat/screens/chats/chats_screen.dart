import 'package:project_bc_tuto/features/Applications/screens/chat/screens/chats/widgets/body.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';


import 'package:flutter/material.dart';





class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body:  ChatBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: JColors.primary,
        child: const Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),

    );
  }


  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: JColors.primary,
      automaticallyImplyLeading: false,
      title: const Text("Chats"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

