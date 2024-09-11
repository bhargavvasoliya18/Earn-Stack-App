import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier{

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isSelectTermsPrivacy = false;
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  visiblePasswordValueUpdate(){
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  visibleConfirmPasswordValueUpdate(){
    isVisibleConfirmPassword = !isVisibleConfirmPassword;
    notifyListeners();
  }

  selectTermsPrivacyValueUpdate(){
    isSelectTermsPrivacy = !isSelectTermsPrivacy;
    notifyListeners();
  }

  signUpButtonOnTap(){
    if(globalFormKey.currentState!.validate()){

    }else{
       validate = AutovalidateMode.onUserInteraction;
       notifyListeners();
    }
  }

}