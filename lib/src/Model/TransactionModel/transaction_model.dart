class TransactionModel {
  String? signUp;
  String? invite;
  String? quiz;
  String? article;

  TransactionModel({this.signUp, this.invite, this.quiz, this.article});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    signUp = json['sign_up'];
    invite = json['invite'];
    quiz = json['quiz'];
    article = json['article'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sign_up'] = signUp;
    data['invite'] = invite;
    data['quiz'] = quiz;
    data['article'] = article;
    return data;
  }
}
