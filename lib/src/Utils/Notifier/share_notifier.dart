import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareNotifier extends ChangeNotifier{

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

}