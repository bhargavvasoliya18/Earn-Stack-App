import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/CommonModel/common_model.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_response_model.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Repository/Services/SharedPref/shared_pref.dart';
import 'package:earn_streak/src/Screens/Auth/login_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/main_screen.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/material.dart';

SharedPref sharedPref = SharedPref();

class AuthHelper {
  getAuthToken() async {
    return await sharedPref.read("authToken");
  }

  Future registerApiCall(context, body) async {
    RegisterResponseModel tempRegisterRequestData = RegisterResponseModel();
    print("request body data $body");
    try {
      var res = await ApiService.request(context, AppUrls.registerUrl, RequestMethods.POST,
          header: commonHeader, requestBody: body, showLogs: true);
      if (res != null && res["success"] == true) {
        showError(message: "Register successfully", background: Colors.blue);
        sharedPref.save("isLogin", true);
        tempRegisterRequestData = RegisterResponseModel.fromJson(res["data"]["user"]);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (Bool) => false);
      }
    } catch (e) {
      print("Register api throw exception $e");
    }
    return tempRegisterRequestData;
  }

  Future loginApiCall(context, body) async {
    LoginResponseModel tempLoginRequestData = LoginResponseModel();
    print("request body data $body");
    try {
      var res = await ApiService.request(context, AppUrls.loginUrl, RequestMethods.POST,
          header: commonHeader, requestBody: body, showLogs: true);
      if (res != null && res["success"] == true) {
        sharedPref.save("isLogin", true);
        showError(message: "Login successfully", background: Colors.blue);
        sharedPref.save("authToken", res["data"]["user"]["auth_token"]);
        tempLoginRequestData = LoginResponseModel.fromJson(res["data"]["user"]);
        updateUserDataSharedPrefs(tempLoginRequestData);
        loadUserDataSharedPrefs();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainScreen()), (Bool) => false);
      }
    } catch (e) {
      print("Register api throw exception $e");
    }
    return tempLoginRequestData;
  }

  Future forgotEmailApiCall(context, email) async {
    bool isSuccess = false;
    try {
      var res = await ApiService.request(context, "${AppUrls.forgotPassWordUrl}?email=$email", RequestMethods.GET, header: commonHeader);
      if (res != null && res["success"] == true) {
        showError(message: "Receive otp this $email", background: Colors.blue);
        isSuccess = true;
      }
    } catch (e) {
      print("Forgot api throw exception $e");
    }
    return isSuccess;
  }

  Future resetPasswordApiCall(context, {String? email, String? token, String? password}) async {
    bool? isSuccess;
    try {
      var res = await ApiService.request(context, "${AppUrls.resetPasswordUrl}?email=$email&token=$token&password=$password", RequestMethods.POST, header: commonHeader);
      if (res != null && res["success"] == true) {
        print("forgot password api response $res");
        isSuccess = true;
      }
    } catch (e) {
      print("Forgot api throw exception $e");
    }
    return isSuccess;
  }

  Future verifyOtpApiCall(context, {String? otp, String? email})async{
    bool? isOtpVerify;
    try{
      var res = await ApiService.request(context, "${AppUrls.verifyOtpUrl}?email=$email&token=$otp", RequestMethods.POST, header: commonHeader);
      if(res != null){
        isOtpVerify = true;
        showError(message: "Otp Verify successfully", background: Colors.blue);
      }
    }
      catch(e){
         print("Verify otp exception $e");
      }
      return isOtpVerify;
  }

  commonApiCall(context)async{
    CommonModel commonModel = CommonModel();
    String authToken = await sharedPref.read("authToken");
    try{
      var res = await ApiService.request(context, AppUrls.commonApiUrl, RequestMethods.POST, header: commonHeaderWithToken(authToken), requestBody: {"user_id": loginResponseModel.id});
      if(res != null && res["data"] != null){
        commonModel = CommonModel.fromJson(res["data"] ?? {});
      }
    }
      catch(e){
        print("Common api call throw exception $e");
      }
      return commonModel;
  }
}
