
import 'package:earn_streak/src/Model/CommonModel/common_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Screens/SplashScreen/splash_screen.dart';
import 'package:flutter/material.dart';


String postUrl = "";

class SettingNotifier extends ChangeNotifier{

  CommonModel commonModel = CommonModel();
  bool isCommonApiComplete = false;


  getCommonUrlApiCall(context)async{
    print("get common api call");
    // await AuthHelper().commonApiCall(context);
    commonModel = await AuthHelper().commonApiCall(context);
    postUrl = commonModel.postBaseUrl ?? "";
    sharedPref.save("minimumCoin", commonModel.requiredRedeemCoin);
    print("set post url int $postUrl");
    notifyListeners();
  }

}
