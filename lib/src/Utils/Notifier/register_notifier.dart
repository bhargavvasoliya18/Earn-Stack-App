import 'dart:io';

import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_request_model.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app_utils.dart';

class RegisterNotifier extends ChangeNotifier {
  RegisterRequestModel registerRequestModel = RegisterRequestModel();
  RegisterResponseModel registerResponseModel = RegisterResponseModel();

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;

  bool isSelectTermsPrivacy = false;
  bool isVisiblePassword = true;
  bool isVisibleConfirmPassword = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  Future<void> googleLogin(context) async {
    _googleSignIn.disconnect();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        String email = googleUser.email;
        String firstName = googleUser.displayName!.split(" ")[0];
        String? lastName = googleUser.displayName!.split(" ")[1];

        debugPrint("get data firebase is ${googleUser.displayName}");
        debugPrint("get data token is ${credential.accessToken}");
        if (credential.accessToken != null) {
          Map<String, dynamic> body = {
            "email": email,
            "device_type": Platform.operatingSystem,
            "token": credential.accessToken,
            "login_type": "gmail",
            "device_token": "",
            "first_name": firstName,
            "last_name": lastName,
            "username": email,
            "auth_token": googleAuth.accessToken
          };
          await AuthHelper().registerApiCall(context, body);
        }
      }
    } catch (error) {
      debugPrint("Google login throw exception $error");
    }
  }

}
