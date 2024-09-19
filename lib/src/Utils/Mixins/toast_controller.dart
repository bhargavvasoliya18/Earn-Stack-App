import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

///ShowToast
showToast( String msg, BuildContext context,
    {Color? backGroundColor, Color? textColor}) {
  FlutterToastr.show(
      msg,
      context,
      duration: 1,
      backgroundColor: backGroundColor ?? Color(0xff4c4DDC));
}
