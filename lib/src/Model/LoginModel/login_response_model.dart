class LoginResponseModel {
  String? id;
  String? authToken;
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

  LoginResponseModel(
      {this.id,
        this.authToken,
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
      });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
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
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['login_type'] = loginType;
    data['user_registered'] = userRegistered;
    data['roles'] = roles;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    data['large'] = large;
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
