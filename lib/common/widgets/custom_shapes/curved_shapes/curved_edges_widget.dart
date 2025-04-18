import 'package:flutter/material.dart';

import 'curved_edges.dart';


class CurvedEdgeswidgets extends StatelessWidget {
  const CurvedEdgeswidgets({
    super.key, this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: CustomCurvedEdges(),
        child: child
    );
  }
}
