
import 'package:flutter/material.dart';

class MatrixGrid extends StatelessWidget {
  final List<Widget> items;
  final int totalLenght;
  final int crossCount;
  final double crossSpacing;
  final double mainSpacing;
  final bool isScrollable;


  const MatrixGrid({
    super.key,
    required this.items,
    this.totalLenght = 4,
    this.crossCount =2,
    this.crossSpacing = 0.8,
    this.mainSpacing = 0.8,
    this.isScrollable = false,


  });

  @override
  Widget build(BuildContext context) {
    // Optionally assert that items.length == 4
    assert(items.length == totalLenght, 'TwoByTwoGrid requires exactly four items.');

    return GridView.count(

      physics: isScrollable ?  NeverScrollableScrollPhysics() :  AlwaysScrollableScrollPhysics(),


      shrinkWrap: true,


      crossAxisCount: crossCount,


      crossAxisSpacing: crossSpacing,
      mainAxisSpacing: mainSpacing,


      children: items,
    );
  }
}
