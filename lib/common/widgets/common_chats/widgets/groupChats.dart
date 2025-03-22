import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import 'chatscreen.dart';

class GroupChatsScreen extends StatelessWidget {
  const GroupChatsScreen({super.key, this.isSend = false,  this.isRead = false,});

  final bool isSend;
  final bool isRead;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(JSizes.md),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ChatScreen(isGroupChat: true));
            },
            child: JRoundedContainer(
              height: 80,
              padding: EdgeInsets.all(JSizes.sm),
              margin: EdgeInsets.symmetric(vertical: JSizes.xs),
              backgroundColor: Colors.transparent,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.person),
                      ),

                      SizedBox(width: JSizes.md,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Team Chat ${index + 1}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 190,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "Guys please how is the frontend going?",
                              style: Theme.of(context).textTheme.bodyMedium!.apply(color: JColors.darkGrey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("3d ago", style: TextStyle(color: JColors.darkGrey, fontSize: 13),),

                      SizedBox(width: JSizes.xs,),
                      isSend
                          ? (isRead
                          ? Icon(Icons.check,  size: 15, color: JColors.primary)
                          : Icon(Icons.check, size: 15, color: JColors.darkGrey))
                          : Icon(Icons.access_time, size: 15, color: JColors.darkGrey),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
