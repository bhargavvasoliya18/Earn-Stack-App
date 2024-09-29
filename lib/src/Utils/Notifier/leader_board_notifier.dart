import 'package:flutter/material.dart';
import '../../Constants/api_url.dart';
import '../../Model/LenderBoardModel/lender_board_model.dart';
import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Networking/ApiService/api_service.dart';

class LeaderBoardNotifier extends ChangeNotifier {
  int selectIndex = 0;

  selectTabIndex(index, context, parPageData, page, userId, type) {
    selectIndex = index;
    lenderBoardApiCall(context, parPageData, page, userId, type);
    notifyListeners();
  }

  List<LenderBoardData> lenderBoardList = [];

  Future lenderBoardApiCall(context, parPageData, page, userId, type) async {
    String authToken = await sharedPref.read("authToken");
    lenderBoardList.clear();
    try {
      var res = await ApiService.request(
        context,
        "${AppUrls.leaderBoard}?per_page_data=$parPageData&page=$page&user_id=$userId&type=$type",
        RequestMethods.POST,
        header: commonHeaderWithToken(authToken),
      );
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          LenderBoardData tempData = LenderBoardData.fromJson(element ?? {});
          lenderBoardList.add(tempData);
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Register api throw exception $e");
    }
    return lenderBoardList;
  }
}
