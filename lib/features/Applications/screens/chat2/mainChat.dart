import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat2/widget/categories_selector.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat2/widget/favorites.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat2/widget/menu_chat.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class Mainchat extends StatelessWidget {
  const Mainchat({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatHomePage();
  }
}

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
        title: Text(
          "Home Chat",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        leadingIcon: Icons.menu,
        leadingIconSize: 30.0,
        leadingOnPressed: () {},
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                size: 30.0,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              CategoriesSelector(),
              Container(
                decoration: BoxDecoration(
                    color: dark ? JColors.darkerGrey : JColors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20,),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.xxs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Favorite Contact',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_horiz, size: 30,)
                          )
                        ],
                      ),
                    ),
                    FavoritesContacts(),
                    SizedBox(height: JSizes.spaceBtwItems,),
                    MenuChat(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
