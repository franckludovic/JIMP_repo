import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/companies/Interview_cards.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../screens/search_page/widgets/SearchTextField.dart';

class InterviewsScreens extends StatelessWidget {
  const InterviewsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Interviews", style: Theme.of(context).textTheme.headlineMedium,),
        showBackArrow: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_alt_rounded, size: 35,))
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: JSizes.spaceBtwSections ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(child: SearchTextField()),
            ),





            Padding(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: SizedBox(
                child:  JGridLayout(itemCount: 15,crossAxisCount: 1, mainAxisExtend: 110, itemBuilder: (index, _) => JUserInterviewCards())
                ,
              )
            ),
          ],
        ),
      ),
    );
  }
}
