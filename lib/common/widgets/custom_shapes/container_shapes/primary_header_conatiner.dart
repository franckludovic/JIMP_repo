import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/curved_shapes/curved_edges_widget.dart';

import '../../../../utils/constants/colors.dart';
import 'Cirular_shape.dart';

class JPrimaryHeaderContainer extends StatelessWidget {
  const JPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return JCurvedEdgeswidgets(
      child: Container(
        color: JColors.primary,
        padding: const EdgeInsets.only(bottom: 0),
      
        ///if [size.idFinite: is not true.in Stack] error occured -> README.ad file
        child: SizedBox(
         // height: 370,
          ///--background custom shapes
          child: Stack(
            children: [
              Positioned(
                  top: -180,
                  right: -250,
                  child: JCircularContainer(
                      backgroundColor: JColors.textWhite.withAlpha((0.1 * 255).toInt()))),
              Positioned(
                  top: 90,
                  right: -300,
                  child: JCircularContainer(
                      backgroundColor: JColors.textWhite.withAlpha((0.1 * 255).toInt()))),
              child,
            ],
          ),
      
      ),
    )
    );
  }
}
