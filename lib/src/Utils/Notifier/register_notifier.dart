import 'dart:io';

import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_request_model.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:flutter/material.dart';

class RegisterNotifier extends ChangeNotifier{

  RegisterRequestModel registerRequestModel = RegisterRequestModel();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isSelectTermsPrivacy = false;
  bool isVisiblePassword = true;
  bool isVisibleConfirmPassword = true;

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

  signUpButtonOnTap(context){
    if((globalFormKey.currentState?.validate() ?? false)){
      registerApiCall(context);
    }else{
       validate = AutovalidateMode.onUserInteraction;
       notifyListeners();
    }
  }

  registerApiCall(context)async{
    registerRequestModel = RegisterRequestModel(email: registerEmailController.text, lastName: registerNameController.text, firstName: registerNameController.text, password: registerConfirmPasswordController.text, deviceToken: "Abc", deviceType: Platform.operatingSystem, loginType: "Email", userName: registerEmailController.text, country: "");
    registerResponseModel = await AuthHelper().registerApiCall(context, registerRequestModel.toJson());
  }

}