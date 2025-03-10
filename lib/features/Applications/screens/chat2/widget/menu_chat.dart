import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/screens/chat2/models/message_model.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';

class MenuChat extends StatefulWidget {
  const MenuChat({super.key});

  @override
  State<MenuChat> createState() => _MenuChatState();
}

class _MenuChatState extends State<MenuChat> {

  @override

  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);



    return Container(
      height: JDeviceUtils.getScreenHeight(),
      decoration: BoxDecoration(
           borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          )
      ),
      child: ListView.builder (
        itemCount: chats.length ,
        itemBuilder: (BuildContext context, int index) {
        final Messages chat = chats[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal:  JSizes.sm, vertical: JSizes.xs),
          child: JRoundedContainer(
            height: 100,
            backgroundColor: JColors.white,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage(chat.sender.imageUrl),

                ),

                Column(
                  children: [


                  ],
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}
