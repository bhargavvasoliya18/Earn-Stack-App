import 'package:earn_streak/src/Repository/Services/Navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showProgressThreeDots(BuildContext context,{Color? loaderColor}) {
  showDialog(
      barrierDismissible: false,
      context: NavigationService.navigatorKey.currentContext ?? context,
      builder: (_) => WillPopScope(
            onWillPop: () async => false,
            child: const SpinKitThreeBounce(
              color: Color(0xff4c4DDC),
              size: 25,
            ),
          ));
}

hideProgress(BuildContext context) async {
  Navigator.pop(NavigationService.navigatorKey.currentContext ?? context);
}
