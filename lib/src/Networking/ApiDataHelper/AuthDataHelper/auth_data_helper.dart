import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/LoginModel/login_response_model.dart';
import 'package:earn_streak/src/Model/RegisterModel/register_response_model.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Repository/Services/SharedPref/shared_pref.dart';
import 'package:earn_streak/src/Screens/Auth/login_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/main_screen.dart';
import 'package:flutter/material.dart';

SharedPref sharedPref = SharedPref();

class AuthHelper {

 Future registerApiCall(context, body) async{
   RegisterResponseModel tempRegisterRequestData = RegisterResponseModel();
    print("request body data $body");
    try{
      var res = await ApiService.request(context, AppUrls.registerUrl, RequestMethods.POST, header: commonHeader, requestBody: body, showLogs: true);
       if(res != null && res["success"] == true){
         sharedPref.save("isLogin", true);
         tempRegisterRequestData = RegisterResponseModel.fromJson(res["data"]["user"]);
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (Bool)=> false);
       }
    }
      catch(e){
        print("Register api throw exception $e");
      }
      return tempRegisterRequestData;
  }

 Future loginApiCall(context, body) async{
   LoginResponseModel tempLoginRequestData = LoginResponseModel();
   print("request body data $body");
   try{
     var res = await ApiService.request(context, AppUrls.loginUrl, RequestMethods.POST, header: commonHeader, requestBody: body, showLogs: true);
     if(res != null && res["success"] == true){
       sharedPref.save("isLogin", true);
       tempLoginRequestData = LoginResponseModel.fromJson(res["data"]["user"]);
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MainScreen()), (Bool)=> false);
     }
   }
   catch(e){
     print("Register api throw exception $e");
   }
   return tempLoginRequestData;
 }

}