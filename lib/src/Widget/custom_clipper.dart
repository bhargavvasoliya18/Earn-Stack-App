import 'package:flutter/material.dart';

class CircularBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - 50); // Move to near the bottom left
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point at the center bottom
      size.width, size.height - 50, // End point at the bottom right
    );
    path.lineTo(size.width, 0.0); // Right edge
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip as the shape doesn't change
  }
}