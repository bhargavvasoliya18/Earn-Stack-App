class RegisterRequestModel {
  String? email;
  String? password;
  String? deviceType;
  String? deviceToken;
  String? loginType;
  String? firstName;
  String? lastName;
  String? country;
  String? userName;

  RegisterRequestModel(
      {this.firstName,
        this.lastName,
        this.email,
        this.deviceType,
        this.deviceToken,
        this.loginType,
        this.userName,
        this.country,
        this.password
      });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loginType = json['login_type'];
    userName = json['username'];
    country = json['country'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = userName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['login_type'] = loginType;
    data['country'] = country;
    data['password'] = password;
    return data;
  }
}
