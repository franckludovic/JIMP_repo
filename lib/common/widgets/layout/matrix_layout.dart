import 'package:flutter/material.dart';

class MatrixGrid extends StatelessWidget {
  final List<Widget> items;
  final int totalLenght;
  final int crossCount;


  const MatrixGrid({
    super.key,
    required this.items,
    this.totalLenght = 4,
    this.crossCount =2

  });

  @override
  Widget build(BuildContext context) {
    // Optionally assert that items.length == 4
    assert(items.length == totalLenght, 'TwoByTwoGrid requires exactly four items.');

    return GridView.count(

      physics: const NeverScrollableScrollPhysics(),


      shrinkWrap: true,


      crossAxisCount: crossCount,


      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,


      children: items,
    );
  }
}