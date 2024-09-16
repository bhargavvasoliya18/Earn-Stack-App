import 'package:earn_streak/src/Element/responsive_size_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

commonAppBar({double? height}){
 return ClipPath(
    clipper: CircularBottomClipper(),
    child: Container(
      width: setWidth(ScreenUtil().screenWidth),
      height: height ?? 300,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff7979FC), Color(0xff9B9BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
  );
}