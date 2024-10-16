import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/LenderBoardModel/lender_board_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:flutter/cupertino.dart';

class BoardDataHelper {
  Future<List<LenderBoardData>> lenderBoardApiCall(context, userId, type, page, {bool showLoader = false}) async {
    final startTime = DateTime.now();

    List<LenderBoardData> leaderBoard = [];

    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(
          context, "${AppUrls.leaderBoard}?per_page_data=${10}&page=$page&user_id=$userId&type=$type", RequestMethods.POST,
          header: commonHeaderWithToken(authToken), showLoader: showLoader);
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          LenderBoardData tempData = LenderBoardData.fromJson(element ?? {});
          leaderBoard.add(tempData);
        }
      }
    } catch (e) {
      debugPrint("Register api throw exception $e");
    } finally {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      print('API call took: ${duration.inMilliseconds} ms');
    }
    return leaderBoard;
  }
}
