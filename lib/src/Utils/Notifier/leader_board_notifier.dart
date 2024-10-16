import 'package:earn_streak/src/Networking/ApiDataHelper/BoardDataHelper/board_data_helper.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:flutter/material.dart';
import '../../Constants/api_url.dart';
import '../../Model/LenderBoardModel/lender_board_model.dart';
import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Networking/ApiService/api_service.dart';

class LeaderBoardNotifier extends ChangeNotifier {
  int selectIndex = 0;
  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;
  List<LenderBoardData> lenderBoardList = [];

  selectTabIndex(index, context, userId, type) async {
    page = 1;
    lenderBoardList.clear();
    selectIndex = index;
    await getLeaderBoardApiCall(context, showLoader: true);
    notifyListeners();
  }

  iniState(context) async {
    await getLeaderBoardApiCall(context, showLoader: true);
    notifyListeners();
  }

  getLeaderBoardApiCall(context, {bool showLoader = false}) async {
    String type = '';
    if (selectIndex == 0) {
      type = "daily";
    } else if (selectIndex == 1) {
      type = "weekly";
    } else if (selectIndex == 2) {
      type = "monthly";
    }

    List<LenderBoardData> lenderBoardLists =
        await BoardDataHelper().lenderBoardApiCall(context, loginResponseModel.id, type, page, showLoader: showLoader);
    isHaseMoreData = lenderBoardLists.isNotEmpty;
    lenderBoardList.addAll(lenderBoardLists);
    notifyListeners();
  }

  onScroll(BuildContext context) async {
    if (!isLoadMore) {
      isLoadMore = true;
      notifyListeners();
      if (isHaseMoreData) {
        page++;
        await getLeaderBoardApiCall(context, showLoader: false);
      }
      isLoadMore = false;
      await Future.delayed(const Duration(milliseconds: 800));
      notifyListeners();
    }
  }
}
