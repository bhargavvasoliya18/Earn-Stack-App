class LenderBoardResponse {
  bool? success;
  String? message;
  int? totalPage;
  String? currentPage;
  String? perPageData;
  String? totalRecord;
  List<LenderBoardData>? data;

  LenderBoardResponse(
      {this.success, this.message, this.totalPage, this.currentPage, this.perPageData, this.totalRecord, this.data});

  LenderBoardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    perPageData = json['per_page_data'];
    totalRecord = json['total_record'];
    if (json['data'] != null) {
      data = <LenderBoardData>[];
      json['data'].forEach((v) {
        data!.add(LenderBoardData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['total_page'] = totalPage;
    data['current_page'] = currentPage;
    data['per_page_data'] = perPageData;
    data['total_record'] = totalRecord;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LenderBoardData {
  String? iD;
  String? userLogin;
  String? userEmail;
  String? earnappUserEarnCoin;

  LenderBoardData({this.iD, this.userLogin, this.userEmail, this.earnappUserEarnCoin});

  LenderBoardData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userLogin = json['user_login'];
    userEmail = json['user_email'];
    earnappUserEarnCoin = json['earnapp_user_earn_coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['user_login'] = userLogin;
    data['user_email'] = userEmail;
    data['earnapp_user_earn_coin'] = earnappUserEarnCoin;
    return data;
  }
}