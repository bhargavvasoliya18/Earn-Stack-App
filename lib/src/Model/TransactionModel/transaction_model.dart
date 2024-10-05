class TransactionModel {
  String? id;
  String? coin;
  String? history;
  String? createdAt;

  TransactionModel({this.id, this.coin, this.history, this.createdAt});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coin = json['coin'];
    history = json['history'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['coin'] = coin;
    data['history'] = history;
    data['created_at'] = createdAt;
    return data;
  }
}
