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
    return CurvedEdgeswidgets(
      child: Container(
        color: JColors.primary,
        padding: const EdgeInsets.only(bottom: 0),
      

        child: SizedBox(
          height: 250,
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
