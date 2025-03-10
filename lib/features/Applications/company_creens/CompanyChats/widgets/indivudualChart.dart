import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import 'chatscreen.dart';

class IndividualChatsScreen extends StatelessWidget {
  const IndividualChatsScreen({super.key,  this.isSend = false,  this.isRead = false});

  final bool isSend;
  final bool isRead;

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
              height: 90,
              backgroundColor: Colors.blue.shade50,
              padding: EdgeInsets.all(JSizes.sm),
              margin: EdgeInsets.symmetric(vertical: JSizes.xs),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.person),
                      ),

                      SizedBox(width: JSizes.md,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Chat with Candidate ${index + 1}",
                            style: TextStyle(color: JColors.black),
                          ),
                          SizedBox(
                            width: 230,
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "Hello boy life is good when ny#h the",
                              style: TextStyle(color: JColors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("3pm", style: TextStyle(color: JColors.darkGrey, fontSize: 15),),

                      isSend
                          ? (isRead
                          ? Icon(Icons.check, color: JColors.primary)
                          : Icon(Icons.check, color: JColors.darkGrey))
                          : Icon(Icons.access_time, color: JColors.darkGrey),
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
