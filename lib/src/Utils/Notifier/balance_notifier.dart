import 'package:flutter/widgets.dart';

import '../../Constants/api_url.dart';
import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Networking/ApiService/api_service.dart';

class BalanceNotifier extends ChangeNotifier {
  Future paymentUpdateApiCall(context, body) async {
    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(
        context,
        AppUrls.paymentUpdate,
        RequestMethods.POST,
        requestBody: body,
        header: commonHeaderWithToken(authToken),
      );
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          // LenderBoardData tempData = LenderBoardData.fromJson(element ?? {});
          // lenderBoardList.add(tempData);
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint("Register api throw exception $e");
    }
    // return lenderBoardList;
  }
}
