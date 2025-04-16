import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/applications/sortable/sortable_application.dart';

class AllApplications extends StatelessWidget {
  const AllApplications({super.key, this.saves = false});

  final bool saves;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text('Popular Applications',),
        showBackArrow: true,
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(JSizes.defaultSpace),
      //     child: JSortableApplications(saves: saves,),
      //   ),
      // ),
    );
  }
}

