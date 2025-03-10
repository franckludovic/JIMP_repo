import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/CompanyChats/widgets/groupChats.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/CompanyChats/widgets/indivudualChart.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/CompanyChats/widgets/pinnedChats.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Messages", style: Theme.of(context).textTheme.headlineMedium,),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 30,))
          ],

          bottom: const TabBar(
            tabs: [
              Tab(text: "Individual"),
              Tab(text: "Group"),
              Tab(text: "Bookmarked"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            IndividualChatsScreen(),
            GroupChatsScreen(),
            Pinnedchats(),

          ],
        ),
      ),
    );
  }
}
