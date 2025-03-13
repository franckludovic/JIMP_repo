import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../company_creens/proposals/proposal_card.dart';


class ProposalPage extends StatelessWidget {
  const ProposalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: JAppbar(title: Text("Proposals")),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ProposalCard(
              companyName: "Tech Corp",
              jobTitle: "Senior Flutter Developer",
              location: "Remote",
              jobType: "Full Time",
              salary: "\$95,000/year",
              skills: ["Flutter", "Dart", "Firebase"],
              companyLogo: JImages.google,
              postedDate: "2 days ago",
            ),
            ProposalCard(
              companyName: "Tech Corp",
              jobTitle: "Senior Flutter Developer",
              location: "Remote",
              jobType: "Full Time",
              salary: "\$95,000/year",
              skills: ["Flutter", "Dart", "Firebase"],
              companyLogo: JImages.google,
              postedDate: "2 days ago",
            ),
          ],
        ),
    );
  }
}