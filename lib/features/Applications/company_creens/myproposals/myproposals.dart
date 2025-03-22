import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';

import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../screens/proposals_page/proposal_card.dart';
import 'new_proposals.dart';

class Myproposals extends StatelessWidget {
  const Myproposals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Text("My Proposals"), showBackArrow: true,),

      body: SingleChildScrollView(
        child: SizedBox(
          child:JGridLayout(
            itemCount: 5,
            mainAxisExtend: 404,
            crossAxisCount: 1,
            itemBuilder: (_, index) => ProposalCard(
              companyName: "NVIDIA",
              jobTitle: "Backend Developer",
              location: "Cameroon, Bonanpriso, Douala",
              jobType: "Internship",
              jobTag: 'Part Time',
              salary: "195,000/month",
              skills: ["Django", "Node.js", "APIs"],
              companyLogo: JImages.nvidia,
              postedDate: "10 days ago",
              isCompany: true,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(() => SendProposalPage()),
          backgroundColor: JColors.primary,
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          )
      ),
    );
  }
}

