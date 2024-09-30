class CommonModel {
  Social? social;
  String? termsService;
  String? privacyPolicy;
  String? googlePlayStore;
  String? contactUs;

  CommonModel(
      {this.social,
        this.termsService,
        this.privacyPolicy,
        this.googlePlayStore,
        this.contactUs});

  CommonModel.fromJson(Map<String, dynamic> json) {
    social =
    json['social'] != null ? new Social.fromJson(json['social']) : null;
    termsService = json['terms_service'];
    privacyPolicy = json['privacy_policy'];
    googlePlayStore = json['google_play_store'];
    contactUs = json['contact_us'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
}
