import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class Piechardstats extends StatelessWidget {
  const Piechardstats({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                alignment:Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sections: generateSections(),
                      centerSpaceRadius: 50,
                      sectionsSpace: 2,
                      pieTouchData: PieTouchData(enabled: true),
                    ),
                  ),

                  Text("56", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black, ),),
                ],
              ),
            ),
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildLegend(),
          ),
        ],
      ),
    );
  }


  List<PieChartSectionData> generateSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 70,
        title: '20',
        radius: 50,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        badgeWidget: JRoundedContainer(showBorder: true, borderWidth: 2,  borderColor: Colors.green, width: 40, height: 40 ,radius: 40, backgroundColor: JColors.lightGrey, child: Icon(Iconsax.user_tick, color: Colors.black, size: 30,)),
        badgePositionPercentageOffset: 1,
        titlePositionPercentageOffset: 0.3
      ),
      PieChartSectionData(
        color: Colors.orangeAccent,
        value: 20,
        title: '16',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        badgeWidget: JRoundedContainer(showBorder: true, borderWidth: 2,  borderColor: Colors.orangeAccent, width: 40, height: 40 ,radius: 40, backgroundColor: JColors.lightGrey, child: Icon(Icons.question_mark_rounded, color: Colors.black, size: 30,)),
        badgePositionPercentageOffset: 1,
        titlePositionPercentageOffset: 0.3
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 10,
        title: '05',
        radius: 50,
        titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        badgeWidget: JRoundedContainer(showBorder: true, borderWidth: 2,  borderColor: Colors.red, width: 40, height: 40 ,radius: 40, backgroundColor: JColors.lightGrey, child: Icon(Iconsax.user_remove, color: Colors.black, size: 30,)),
        badgePositionPercentageOffset: 1,
        titlePositionPercentageOffset: 0.3
      ),
    ];
  }




  List<Widget> buildLegend() {
    final legendItems = [
      {'color': Colors.green, 'label': 'Accepted'},
      {'color': Colors.amber, 'label': 'Pending'},
      {'color': Colors.red, 'label': 'Rejected'},
    ];

    return legendItems.map((item) {
      return Padding(
        padding: const EdgeInsets.only(top: JSizes.sm),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: item['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              item['label'] as String,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ],
        ),
      );
    }).toList();
  }
}
