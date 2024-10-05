class ArticleModel {
  int? id;
  String? slug;
  String? title;
  String? content;
  String? published;
  String? url;
  Images? images;
  String? coin;
  bool? isQuizComplete;
  bool? isArticleComplete;
  List<Quizs>? quizs;

  ArticleModel(
      {this.id,
        this.slug,
        this.title,
        this.content,
        this.published,
        this.url,
        this.images,
        this.coin,
        this.quizs,
        this.isArticleComplete,
        this.isQuizComplete
      });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    content = json['content'];
    published = json['published'];
    url = json['url'];
    images =
    json['images'] != null ? Images.fromJson(json['images']) : null;
    coin = json['coin'];
    if (json['quizs'] != null) {
      quizs = <Quizs>[];
      json['quizs'].forEach((v) {
        quizs!.add(Quizs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['content'] = content;
    data['published'] = published;
    data['url'] = url;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['coin'] = coin;
    if (quizs != null) {
      data['quizs'] = quizs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? original;
  String? large;
  String? medium;
  String? thumbnail;

  Images({this.original, this.large, this.medium, this.thumbnail});

  Images.fromJson(Map<String, dynamic> json) {
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

class Quizs {
  String? question;
  List<Option>? option;
  String? answer;
  String? selectAnswer;

  Quizs({this.question, this.option, this.answer, this.selectAnswer});

  Quizs.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
      });
    }
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    data['answer'] = answer;
    return data;
  }
}

class Option {
  final String s1;

  Option({required this.s1});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(s1: json.values.first); // Assuming the key is dynamic (1, 2, 3,...)
  }

  Map<String, dynamic> toJson() {
    return {
      'option': s1, // Adjust the key as needed
    };
  }
}
