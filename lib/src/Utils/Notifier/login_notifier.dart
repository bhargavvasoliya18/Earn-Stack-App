import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier{
  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isVisiblePassword = false;

  bool isVisibleForgotPassword = true;
  bool isVisibleForgotConfirmPassword = true;

  visiblePasswordValueUpdate(){
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  visibleForgotPasswordValueUpdate(){
    isVisibleForgotPassword = !isVisibleForgotPassword;
    notifyListeners();
  }

  visibleForgotConfirmPasswordValueUpdate(){
    isVisibleForgotConfirmPassword = !isVisibleForgotConfirmPassword;
    notifyListeners();
  }

  loginButtonOnTap(){
    if(globalFormKey.currentState!.validate()){

    }else{
      validate = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }
}