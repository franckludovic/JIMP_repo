import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/Cirular_shape.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';


class JChoiceChip extends StatelessWidget {
  const JChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = JHelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() :  Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? JColors.white : null),
        avatar: isColor
          ? JCircularContainer(width: 50, height: 50, backgroundColor: JHelperFunctions.getColor(text)!)
          : null,
        shape: isColor ? CircleBorder() : null,
        labelPadding: isColor ?  EdgeInsets.all(0) : null,
        padding: isColor ? EdgeInsets.all(0) : null,
        backgroundColor: isColor ? JHelperFunctions.getColor(text)! : null,


      ),
    );
  }
}
