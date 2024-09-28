import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void showSuccess({String? message, Color background = Colors.green}) {
  showToast(
    message,
    context: rootNavigatorKey.currentContext,
    textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
    backgroundColor: background,
    textAlign: TextAlign.center,
    position: StyledToastPosition.top,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    animDuration: Duration(seconds: 1),
    duration: Duration(seconds: 3),
    curve: Curves.ease,
    borderRadius: BorderRadius.circular(12.sp),
    reverseCurve: Curves.linear,
  );
}

void showError({String? message, Color background = Colors.red}) {
  showToast(
    message,
    context: rootNavigatorKey.currentContext,
    textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
    backgroundColor: background,
    textAlign: TextAlign.center,
    position: StyledToastPosition.top,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    animDuration: Duration(seconds: 1),
    duration: Duration(seconds: 3),
    curve: Curves.ease,
    reverseCurve: Curves.linear,
    borderRadius: BorderRadius.circular(12.sp),
  );
}
