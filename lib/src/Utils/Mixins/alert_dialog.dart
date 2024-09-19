import 'package:earn_streak/src/Style/text_style.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String content,String okButtonText, {VoidCallback? onTapOk,bool isShowCancel = false,String cancelButtonText = ''}) {
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff7979FC)),
    onPressed: onTapOk ?? () async {Navigator.pop(context);},
    child: Text(okButtonText, style: TextStyleTheme.customTextStyle(Colors.black,12,FontWeight.w400)),
  );
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    onPressed:() async {Navigator.pop(context);},
    child: Text(cancelButtonText, style: TextStyleTheme.customTextStyle(Colors.black,12,FontWeight.w400)),
  );
  AlertDialog alert = AlertDialog(
    title: Text(title,style: TextStyleTheme.customTextStyle(Colors.black, 16, FontWeight.w600),),
    content: Text(content),
    actions: [
      isShowCancel == true  ? cancelButton : Container(),
      okButton,
    ],
  );

  /// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}