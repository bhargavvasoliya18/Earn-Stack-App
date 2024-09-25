class LoginRequestModel {
  String? userName;
  String? password;
  String? deviceType;
  String? deviceToken;
  String? loginType;

  LoginRequestModel(
      {this.deviceType,
        this.deviceToken,
        this.loginType,
        this.userName,
        this.password
      });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loginType = json['login_type'];
    userName = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = userName;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['login_type'] = loginType;
    data['password'] = password;
    return data;
  }
}
