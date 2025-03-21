import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../company_creens/proposals/proposal_card.dart';


class ProposalPage extends StatelessWidget {
  const ProposalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: JAppbar(title: Text("Proposals", style: Theme.of(context).textTheme.headlineMedium,),
          showBackArrow: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProposalCard(
              companyName: "NVIDIA",
              jobTitle: "Backend Developer",
              location: "Cameroon, Bonanpriso, Douala",
              jobType: "Internship",
              jobTag: 'Part Time',
              salary: "195,000/month",
              skills: ["Django", "Node.js", "APIs"],
              companyLogo: JImages.nvidia,
              postedDate: "10 days ago",
            ),
            ProposalCard(
              companyName: "Google",
              jobTitle: "Senior Flutter Developer",
              jobType: "Job",
              location: "Remote",
              jobTag: 'Full Time',
              salary: "295,000/year",
              skills: ["Flutter", "Dart", "Firebase"],
              companyLogo: JImages.google,
              postedDate: "2 days ago",
            ),
          ],
        ),
    );
  }
}