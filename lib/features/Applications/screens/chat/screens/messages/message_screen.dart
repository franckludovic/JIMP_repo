import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat/screens/messages/widgets/body.dart';



class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('Metatiel', style: Theme.of(context).textTheme.bodyLarge,),
        Text('Active 3m ago', style: Theme.of(context).textTheme.bodyLarge,)
      ],),
        showBackArrow: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, size: 30,))
        ],
      ),
      body: const MessageBody(),
    );
  }

}
