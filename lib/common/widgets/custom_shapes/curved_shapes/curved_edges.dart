import 'package:flutter/material.dart';

class CustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.lineTo(0, size.height - 15);

    // First small curve (left dip)
    Offset firstControlPoint = Offset(size.width /12, size.height + 2);
    Offset firstEndPoint = Offset(size.width /15, size.height + 3 );
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Middle big curve (raise the peak higher)
    Offset secondControlPoint = Offset(size.width * 0.5, size.height - 90);
    Offset secondEndPoint = Offset(size.width * 0.9, size.height - 10);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    // Last small curve (right rise)
    Offset thirdControlPoint = Offset(size.width * 0.95, size.height);
    Offset thirdEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy, thirdEndPoint.dx, thirdEndPoint.dy);

    // Close the shape
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

