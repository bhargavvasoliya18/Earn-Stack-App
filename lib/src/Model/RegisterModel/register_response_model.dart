class RegisterResponseModel {
  int? id;
  String? authToken;
  String? name;
  String? displayName;
  String? firstName;
  String? lastName;
  String? email;
  String? deviceType;
  String? deviceToken;
  String? loginType;
  String? userRegistered;
  List<String>? roles;

  RegisterResponseModel(
      {this.id,
        this.authToken,
        this.name,
        this.displayName,
        this.firstName,
        this.lastName,
        this.email,
        this.deviceType,
        this.deviceToken,
        this.loginType,
        this.userRegistered,
        this.roles});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    name = json['name'];
    displayName = json['display_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    loginType = json['login_type'];
    userRegistered = json['user_registered'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['auth_token'] = authToken;
    data['name'] = name;
    data['display_name'] = displayName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['login_type'] = loginType;
    data['user_registered'] = userRegistered;
    data['roles'] = roles;
    return data;
  }
}
