import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat2/models/message_model.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class FavoritesContacts extends StatefulWidget {
  const FavoritesContacts({super.key});

  @override
  State<FavoritesContacts> createState() => _FavoritesContactsState();
}

class _FavoritesContactsState extends State<FavoritesContacts> {
  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 100,
      child: ListView.builder(
          padding: EdgeInsets.only(left: JSizes.md),
          scrollDirection: Axis.horizontal,
          itemCount: favorite.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(JSizes.sm),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage(favorite[index].imageUrl),
                    ),
                  ),
                  Text(
                    favorite[index].name,
                    style: TextStyle(
                      color: dark ? JColors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.8,

                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
