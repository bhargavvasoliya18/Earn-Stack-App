class UserDetailsModel {
  int? id;
  String? name;
  String? displayName;
  String? firstName;
  String? lastName;
  String? email;
  Profile? profile;
  String? deviceType;
  String? deviceToken;
  String? loginType;
  String? userRegistered;
  List<String>? roles;
  String? signUpCoin;
  String? inviteCoin;
  String? quizCoin;
  String? articleCoin;
  String? referralCode;
  int? totalCoin;
  String? redeem;
  int? earning;

UserDetailsModel(
      {this.id,
        this.name,
        this.displayName,
        this.firstName,
        this.lastName,
        this.email,
        this.profile,
        this.deviceType,
        this.deviceToken,
        this.loginType,
        this.userRegistered,
        this.roles,
        this.signUpCoin,
        this.inviteCoin,
        this.quizCoin,
        this.articleCoin,
        this.referralCode,
        this.totalCoin,
        this.redeem,
        this.earning});

UserDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loginType = json['login_type'];
    userRegistered = json['user_registered'];
    roles = json['roles'].cast<String>();
    signUpCoin = json['sign_up_coin'];
    inviteCoin = json['invite_coin'];
    quizCoin = json['quiz_coin'];
    articleCoin = json['article_coin'];
    referralCode = json['referral_code'];
    totalCoin = json['total_coin'];
    redeem = json['redeem'];
    earning = json['earning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['login_type'] = this.loginType;
    data['user_registered'] = this.userRegistered;
    data['roles'] = this.roles;
    data['sign_up_coin'] = this.signUpCoin;
    data['invite_coin'] = this.inviteCoin;
    data['quiz_coin'] = this.quizCoin;
    data['article_coin'] = this.articleCoin;
    data['referral_code'] = this.referralCode;
    data['total_coin'] = this.totalCoin;
    data['redeem'] = this.redeem;
    data['earning'] = this.earning;
    return data;
  }
}

class Profile {
  dynamic original;
  dynamic large;
  dynamic medium;
  dynamic thumbnail;

  Profile({this.original, this.large, this.medium, this.thumbnail});

  Profile.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    data['large'] = this.large;
    data['medium'] = this.medium;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
