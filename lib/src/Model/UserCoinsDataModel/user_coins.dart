class UserCoins {
  String? signUpCoin;
  String? inviteCoin;
  String? quizCoin;
  String? articleCoin;
  String? reedmCoin;
  int? total;

  UserCoins(
      {this.signUpCoin,
        this.inviteCoin,
        this.quizCoin,
        this.articleCoin,
        this.reedmCoin,
        this.total});

  UserCoins.fromJson(Map<String, dynamic> json) {
    signUpCoin = json['sign_up_coin'];
    inviteCoin = json['invite_coin'];
    quizCoin = json['quiz_coin'];
    articleCoin = json['article_coin'];
    reedmCoin = json['reedm_coin'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sign_up_coin'] = signUpCoin;
    data['invite_coin'] = inviteCoin;
    data['quiz_coin'] = quizCoin;
    data['article_coin'] = articleCoin;
    data['reedm_coin'] = reedmCoin;
    data['total'] = total;
    return data;
  }
}
