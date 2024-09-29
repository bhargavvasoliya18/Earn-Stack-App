import 'dart:io';

import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_request_model.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:flutter/material.dart';

import '../app_utils.dart';

class RegisterNotifier extends ChangeNotifier {
  RegisterRequestModel registerRequestModel = RegisterRequestModel();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isSelectTermsPrivacy = false;
  bool isVisiblePassword = true;
  bool isVisibleConfirmPassword = true;

  visiblePasswordValueUpdate() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  visibleConfirmPasswordValueUpdate() {
    isVisibleConfirmPassword = !isVisibleConfirmPassword;
    notifyListeners();
  }

  selectTermsPrivacyValueUpdate() {
    isSelectTermsPrivacy = !isSelectTermsPrivacy;
    notifyListeners();
  }

  bool isValidateLogin() {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (registerNameController.text.isEmpty || registerNameController.text == "") {
      showError(message: "Please enter name");
      return false;
    } else if (registerEmailController.text.isEmpty || registerEmailController.text == "") {
      showError(message: "Please enter email");
      return false;
    } else if (!regExp.hasMatch(registerEmailController.text)) {
      showError(message: "Please enter valid email");
      return false;
    } else if (registerPasswordController.text.isEmpty || registerPasswordController.text == "") {
      showError(message: "Please enter password");
      return false;
    } else if (registerConfirmPasswordController.text.isEmpty || registerConfirmPasswordController.text == "") {
      showError(message: "Please enter confirm password");
      return false;
    } else if (registerPasswordController.text != registerConfirmPasswordController.text) {
      showError(message: "Password & Confirm password are not same");
      return false;
    }
    return true;
  }

  initState(){
    registerNameController.text = "";
    registerEmailController.text = "";
    registerPasswordController.text = "";
    registerConfirmPasswordController.text = "";
  }

  signUpButtonOnTap(context) {
    // if ((globalFormKey.currentState?.validate() ?? false)) {
    if (isValidateLogin()) {
      if(isSelectTermsPrivacy == true){
        registerApiCall(context);
      }else{
        showError(message: "Please select terms and privacy");
      }
    } else {
      validate = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
  }

  registerApiCall(context) async {
    registerRequestModel = RegisterRequestModel(
        email: registerEmailController.text,
        lastName: registerNameController.text,
        firstName: registerNameController.text,
        password: registerConfirmPasswordController.text,
        deviceToken: "Abc",
        deviceType: Platform.operatingSystem,
        loginType: "Email",
        userName: registerEmailController.text,
        country: "");
    registerResponseModel = await AuthHelper().registerApiCall(context, registerRequestModel.toJson());
  }
}
