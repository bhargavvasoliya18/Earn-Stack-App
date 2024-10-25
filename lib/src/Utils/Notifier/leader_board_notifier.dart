import 'package:earn_streak/src/Networking/ApiDataHelper/BoardDataHelper/board_data_helper.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:flutter/material.dart';
import '../../Model/LenderBoardModel/lender_board_model.dart';

class LeaderBoardNotifier extends ChangeNotifier {
  int selectIndex = 0;
  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;
  List<LenderBoardData> lenderBoardList = [];
  List<LenderBoardData> weeklyLenderBoardList = [];
  List<LenderBoardData> monthlyLenderBoardList = [];

  selectTabIndex(index, context, userId, type) async {
    page = 1;
    isHaseMoreData = true;
    selectIndex = index;
    notifyListeners();
  }

  iniState(context) async {
    Future.delayed(Duration(milliseconds: 200), ()async{
      if(lenderBoardList.isEmpty){
        await getLeaderBoardApiCall(context, showLoader: true, type: "daily");
      }
    });
    Future.delayed(Duration(milliseconds: 200), ()async{
      if(weeklyLenderBoardList.isEmpty){
        await getLeaderBoardApiCall(context, showLoader: false, type: "weekly");
      }
    });
    Future.delayed(Duration(milliseconds: 200), ()async{
      if(monthlyLenderBoardList.isEmpty){
        await getLeaderBoardApiCall(context, showLoader: false, type: "monthly");
      }
    });
    notifyListeners();
  }

  getLeaderBoardApiCall(context, {bool showLoader = false, String? type}) async {
    List<LenderBoardData> lenderBoardLists = await BoardDataHelper().lenderBoardApiCall(context, loginResponseModel.id, type, page, showLoader: showLoader);
    if (type == "daily") {
      isHaseMoreData = lenderBoardLists.isNotEmpty;
      lenderBoardList.addAll(lenderBoardLists);
      notifyListeners();
    } else if (type == "weekly") {
      isHaseMoreData = lenderBoardLists.isNotEmpty;
      weeklyLenderBoardList.addAll(lenderBoardLists);
      notifyListeners();
    } else if (type == "monthly") {
      isHaseMoreData = lenderBoardLists.isNotEmpty;
      monthlyLenderBoardList.addAll(lenderBoardLists);
      notifyListeners();
    }
  }

  onScroll(BuildContext context) async {
    String? type;
    if(selectIndex == 0){
      type = "daily";
    }
    else if(selectIndex == 1){
      type = "weekly";
    }
    else if(selectIndex == 2){
      type = "monthly";
    }
    if (!isLoadMore) {
      if (isHaseMoreData) {
        isLoadMore = true;
        notifyListeners();
        page++;
        await getLeaderBoardApiCall(context, showLoader: false, type: type);
      }
      await Future.delayed(const Duration(milliseconds: 800));
      isLoadMore = false;
      notifyListeners();
    }
  }

  pullToRefresh(context){
    page = 1;
    isHaseMoreData = true;
    String? type;
    if(selectIndex == 0){
      lenderBoardList.clear();
      notifyListeners();
      type = "daily";
    }
    else if(selectIndex == 1){
      weeklyLenderBoardList.clear();
      notifyListeners();
      type = "weekly";
    }
    else if(selectIndex == 2){
      monthlyLenderBoardList.clear();
      notifyListeners();
      type = "monthly";
    }
    getLeaderBoardApiCall(context, type: type, showLoader: true);
  }

}
