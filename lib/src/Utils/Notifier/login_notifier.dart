import 'dart:io';

import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/LoginModel/login_request_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:flutter/material.dart';

LoginResponseModel loginResponseModel = LoginResponseModel();

class LoginNotifier extends ChangeNotifier{

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isVisiblePassword = true;
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

  loginButtonOnTap(context){
    // push(context, OnBoardingScreen());
    if((globalFormKey.currentState?.validate() ?? false)){
      loginApiCall(context);
    }else{
      validate = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  loginApiCall(context)async{
    LoginRequestModel loginRequestModel = LoginRequestModel(userName: loginEmailController.text, password: loginPasswordController.text, loginType: "Email", deviceType: Platform.operatingSystem, deviceToken: "Abcv");
   loginResponseModel = await AuthHelper().loginApiCall(context, loginRequestModel.toJson());
  }

  forgotApiCall(context, email)async{
    return await AuthHelper().forgotEmailApiCall(context, email);
  }

}

updateUserDataSharedPrefs(LoginResponseModel loginUserData) {
  sharedPref.save("userData", loginUserData.toJson());
  loadUserDataSharedPrefs();
}

loadUserDataSharedPrefs() async{
  var data = await sharedPref.read("userData");
  LoginResponseModel user = data != null ? LoginResponseModel.fromJson(data) : LoginResponseModel();
  loginResponseModel = user;
}