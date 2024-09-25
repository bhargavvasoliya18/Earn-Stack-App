import 'dart:io';

import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/LoginModel/login_request_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Screens/Auth/Module/forgot_password_dialog.dart';
import 'package:earn_streak/src/Screens/OnbordingScreen/onboarding_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier{
  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  LoginResponseModel loginResponseModel = LoginResponseModel();

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
    return  await AuthHelper().forgotEmailApiCall(context, email);
  }

}