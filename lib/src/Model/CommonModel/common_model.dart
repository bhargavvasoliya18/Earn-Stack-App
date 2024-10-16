/*
class CommonModel {
  String? postBaseUrl;
  String? homeTitle;
  String? homeSubTitle;
  Social? social;
  String? termsService;
  String? privacyPolicy;
  String? googlePlayStore;
  String? contactUs;

  CommonModel(
      {this.postBaseUrl,
        this.homeTitle,
        this.homeSubTitle,
        this.social,
        this.termsService,
        this.privacyPolicy,
        this.googlePlayStore,
        this.contactUs});

  CommonModel.fromJson(Map<String, dynamic> json) {
    postBaseUrl = json['post_base_url'];
    homeTitle = json['home_title'];
    homeSubTitle = json['home_sub_title'];
    social =
    json['social'] != null ? Social.fromJson(json['social']) : null;
    termsService = json['terms_service'];
    privacyPolicy = json['privacy_policy'];
    googlePlayStore = json['google_play_store'];
    contactUs = json['contact_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_base_url'] = postBaseUrl;
    data['home_title'] = homeTitle;
    data['home_sub_title'] = homeSubTitle;
    if (social != null) {
      data['social'] = social!.toJson();
    }
    data['terms_service'] = termsService;
    data['privacy_policy'] = privacyPolicy;
    data['google_play_store'] = googlePlayStore;
    data['contact_us'] = contactUs;
    return data;
  }
}

class Social {
  String? instgram;
  String? facebook;
  String? whatsapp;
  String? youtube;

  Social({this.instgram, this.facebook, this.whatsapp, this.youtube});

  Social.fromJson(Map<String, dynamic> json) {
    instgram = json['instgram'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instgram'] = instgram;
    data['facebook'] = facebook;
    data['whatsapp'] = whatsapp;
    data['youtube'] = youtube;
    return data;
  }
}*/

class CommonModel {
  String? postBaseUrl;
  String? requiredRedeemCoin;
  String? homeTitle;
  String? homeSubTitle;
  Social? social;
  String? termsService;
  String? privacyPolicy;
  String? googlePlayStore;
  String? contactUs;

CommonModel(
      {this.postBaseUrl,
        this.requiredRedeemCoin,
        this.homeTitle,
        this.homeSubTitle,
        this.social,
        this.termsService,
        this.privacyPolicy,
        this.googlePlayStore,
        this.contactUs});

CommonModel.fromJson(Map<String, dynamic> json) {
    postBaseUrl = json['post_base_url'];
    requiredRedeemCoin = json['required_redeem_coin'];
    homeTitle = json['home_title'];
    homeSubTitle = json['home_sub_title'];
    social =
    json['social'] != null ? new Social.fromJson(json['social']) : null;
    termsService = json['terms_service'];
    privacyPolicy = json['privacy_policy'];
    googlePlayStore = json['google_play_store'];
    contactUs = json['contact_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_base_url'] = this.postBaseUrl;
    data['required_redeem_coin'] = this.requiredRedeemCoin;
    data['home_title'] = this.homeTitle;
    data['home_sub_title'] = this.homeSubTitle;
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    data['terms_service'] = this.termsService;
    data['privacy_policy'] = this.privacyPolicy;
    data['google_play_store'] = this.googlePlayStore;
    data['contact_us'] = this.contactUs;
    return data;
  }
}

class Social {
  String? instgram;
  String? facebook;
  String? whatsapp;
  String? youtube;
  bool? twitter;
  bool? linkdin;
  bool? telegram;
  bool? snapchat;

  Social(
      {this.instgram,
        this.facebook,
        this.whatsapp,
        this.youtube,
        this.twitter,
        this.linkdin,
        this.telegram,
        this.snapchat});

  Social.fromJson(Map<String, dynamic> json) {
    instgram = json['instgram'];
    facebook = json['facebook'];
    whatsapp = json['whatsapp'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    linkdin = json['linkdin'];
    telegram = json['telegram'];
    snapchat = json['snapchat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instgram'] = this.instgram;
    data['facebook'] = this.facebook;
    data['whatsapp'] = this.whatsapp;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['linkdin'] = this.linkdin;
    data['telegram'] = this.telegram;
    data['snapchat'] = this.snapchat;
    return data;
  }
}

