import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/screens/application_reviews/widgets/progress_indicator_and_rating.dart';


class JOverallRatingIndicator extends StatelessWidget {
  const JOverallRatingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Text("4.8", style: Theme.of(context).textTheme.displayLarge,)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              JRatingProgressIndicator(text: '5', value: 1.0,),
              JRatingProgressIndicator(text: '4', value: 0.8,),
              JRatingProgressIndicator(text: '3', value: 0.6,),
              JRatingProgressIndicator(text: '2', value: 0.4,),
              JRatingProgressIndicator(text: '1', value: 0.2,),
            ],
          ),
        )
      ],
    );
  }
}

