import 'package:earn_streak/src/Model/CommonModel/common_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:flutter/material.dart';

class SettingNotifier extends ChangeNotifier{

  CommonModel commonModel = CommonModel();

  getCommonUrlApiCall(context)async{
    commonModel = await AuthHelper().commonApiCall(context);
    notifyListeners();
  }

}