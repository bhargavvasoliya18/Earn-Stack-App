import 'dart:io';
import 'package:earn_streak/src/Utils/Mixins/alert_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool?> isNetworkAvailable(BuildContext context)async{
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    showAlertDialog(context, "Oops", "Please check your network connectivity.", "Ok");
    return false;
  }
}

