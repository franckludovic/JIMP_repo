import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
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
      backgroundColor: JColors.primary,
      appBar: JAppbar(title: Text('Chats', style: Theme.of(context).textTheme.headlineMedium), actions: [ IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, size: 30,))],),
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

