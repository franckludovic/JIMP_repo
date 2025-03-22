import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import 'chatscreen.dart';

class IndividualChatsScreen extends StatelessWidget {
  const IndividualChatsScreen({super.key,  this.isSend = false,  this.isRead = false, this.isActive = true});

  final bool isSend;
  final bool isRead;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    // Replace with your actual chat channels (ListTile widgets)
    return Padding(
      padding: const EdgeInsets.all(JSizes.md),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(() => const ChatScreen(isGroupChat: false));
            },
            child: JRoundedContainer(
              height: 80,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.all(JSizes.sm),
              margin: EdgeInsets.symmetric(vertical: JSizes.xs),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [

                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person)
                          ),
                          if (isActive)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  color: JColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      width: 3),
                                ),
                              ),
                            )
                        ],
                      ),

                      SizedBox(width: JSizes.md,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Candidate Chat ${index + 1}",
                            style:  Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(
                            width: 190,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "Hello boy life is good when ny#h the",
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
