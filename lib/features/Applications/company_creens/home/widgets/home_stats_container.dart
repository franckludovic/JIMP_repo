import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CompanyStatsBox extends StatelessWidget {
  const CompanyStatsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            children: const [
              Text(
                "Last 30 Days",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(width: 5),
              Text(
                "+12%",
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
        ),
        // Bar Chart
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: BarChart(
              BarChartData(
                maxY: 100,

                barGroups: [
                  // "Applied" bar (value: 80)
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 80,
                        color: Colors.blue.shade400,
                        width: 50,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                      ),
                    ],
                  ),
                  // "Accepted" bar (value: 60)
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 60,
                        color: Colors.green.shade400,
                        width: 50,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                      ),
                    ],
                  ),
                  // "rejected" bar (value: 75)
                  BarChartGroupData(
                    x: 2,
                    barRods: [
                      BarChartRodData(
                        toY: 85,
                        color: Colors.red.shade400,
                        width: 50,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                      ),
                    ],
                  ),
                  // "Not Applied" bar (value: 20)
                  BarChartGroupData(
                    x: 3,
                    barRods: [
                      BarChartRodData(
                        toY: 13,
                        color: Colors.grey.shade400,
                        width: 50,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(6), topLeft: Radius.circular(6)),
                      ),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 20,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(

                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 25,
                      //margin: 10,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        switch (value.toInt()) {
                          case 0:
                            return const Text("Applied", style: TextStyle(color: Colors.black, fontSize: 12));
                          case 1:
                            return const Text("Accepted", style: TextStyle(color: Colors.black, fontSize: 12));
                          case 2:
                            return const Text("Rejected", style: TextStyle(color: Colors.black, fontSize: 12));
                          case 3:
                            return const Text("Not Applied", style: TextStyle(color: Colors.black, fontSize: 12));
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,

                ),
                gridData: FlGridData(show: false),

                barTouchData: BarTouchData(enabled: true),
                alignment: BarChartAlignment.spaceAround,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
