import 'dart:io';
import 'package:earn_streak/src/Element/textfield_controller.dart';
import 'package:earn_streak/src/Model/CommonModel/common_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_request_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../app_utils.dart';

LoginResponseModel loginResponseModel = LoginResponseModel();
final FirebaseMessaging fcm = FirebaseMessaging.instance;

class LoginNotifier extends ChangeNotifier {

  String? verifyEmail;
  String? verifyToken;

  bool isVisiblePassword = true;
  bool isVisibleForgotPassword = true;
  bool isVisibleForgotConfirmPassword = true;

  GlobalKey<FormState> globalFormKey = GlobalKey();
  AutovalidateMode validate = AutovalidateMode.disabled;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  visiblePasswordValueUpdate() {
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
  }

  visibleForgotPasswordValueUpdate() {
    isVisibleForgotPassword = !isVisibleForgotPassword;
    notifyListeners();
  }

  visibleForgotConfirmPasswordValueUpdate() {
    isVisibleForgotConfirmPassword = !isVisibleForgotConfirmPassword;
    notifyListeners();
  }

  bool isValidateLogin() {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (loginEmailController.text.isEmpty || loginEmailController.text == "") {
      showError(message: "Please enter email");
      return false;
    } else if (!regExp.hasMatch(loginEmailController.text)) {
      showError(message: "Please enter valid email");
      return false;
    } else if (loginPasswordController.text.isEmpty || loginPasswordController.text == "") {
      showError(message: "Please enter password");
      return false;
    }
    return true;
  }

  loginButtonOnTap(context) {
    if (isValidateLogin()) {
      loginApiCall(context);
    } else {
      validate = AutovalidateMode.onUserInteraction;
      notifyListeners();
    }
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
            "username": email,
            "password": "",
            "device_type": Platform.operatingSystem,
            "login_type": "gmail",
            "auth_token": googleAuth.accessToken,
            "device_token": loginResponseModel.deviceToken
          };
          await AuthHelper().loginApiCall(context, body);
        }
      }
    } catch (error) {
      debugPrint("Google login throw exception $error");
    }
  }

  loginApiCall(context) async {
    LoginRequestModel loginRequestModel = LoginRequestModel(
        userName: loginEmailController.text,
        password: loginPasswordController.text,
        loginType: "Email",
        deviceType: Platform.operatingSystem,
        deviceToken: loginResponseModel.deviceToken);
    loginResponseModel = await AuthHelper().loginApiCall(context, loginRequestModel.toJson());
  }

  forgotApiCall(context, email) async {
    verifyEmail = email;
    notifyListeners();
    return await AuthHelper().forgotEmailApiCall(context, email);
  }

  verifyOtpApiCall(context, token)async{
    verifyToken = token;
    return await AuthHelper().verifyOtpApiCall(context, email: verifyEmail, otp: token);
  }

  resetPasswordApiCall(context, {String? password}) async{
    return await AuthHelper().resetPasswordApiCall(context, email: verifyEmail, token: verifyToken, password: password);
  }

  initState(){
    loginPasswordController.text = "";
    loginEmailController.text = "";
  }

}

updateUserDataSharedPrefs(LoginResponseModel loginUserData) {
  sharedPref.save("userData", loginUserData.toJson());
  loadUserDataSharedPrefs();
}

loadUserDataSharedPrefs() async {
  var data = await sharedPref.read("userData");
  LoginResponseModel user = data != null ? LoginResponseModel.fromJson(data) : LoginResponseModel();
  loginResponseModel = user;
  debugPrint('LOG => ${loginResponseModel.toJson()}');
}
