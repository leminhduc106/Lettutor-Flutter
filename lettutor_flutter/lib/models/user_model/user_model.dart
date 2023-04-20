// ignore_for_file: avoid_print

import 'package:lettutor_flutter/models/user_model/feedback_model.dart';
import 'package:lettutor_flutter/models/user_model/learning_topic_model.dart';
import 'package:lettutor_flutter/models/user_model/test_preparation_model.dart';
import 'package:lettutor_flutter/models/user_model/wallet_model.dart';

class User {
  late String id;
  late String email;
  String? google;
  String? facebook;
  String? apple;
  late String name;
  late String avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  late bool isActivated;
  Wallet? walletInfo;
  late List<String> courses;
  String? requireNote;
  String? level;
  List<LearnTopic>? learnTopics;
  List<TestPreparation>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  List<FeedBack>? feedbacks;

  User({
    required this.id,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.name,
    required this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    required this.isActivated,
    this.walletInfo,
    required this.courses,
    this.requireNote,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
    this.feedbacks,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    email = json['email'] ?? "";
    name = json['name'] ?? "";
    avatar = json['avatar'] ?? "";
    country = json['country'];
    phone = json['phone'] ?? "";
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'] ?? false;
    google = json['google'] ?? "";
    facebook = json['facebook'] ?? "";
    apple = json['apple'] ?? "";

    roles = json['roles']?.cast<String>();
    if (json['walletInfo'] != null) {
      walletInfo = Wallet.fromJson(json['walletInfo']);
    }

    if (json['courses'] != null) {
      courses = [];
      json['courses'].forEach((v) {
        //courses.add(new Null.fromJson(v));
      });
    }

    requireNote = json['requireNote'] ?? "";
    level = json['level'] ?? "";

    if (json['learnTopics'] != null) {
      learnTopics = [];
      json['learnTopics'].forEach((v) {
        learnTopics?.add(LearnTopic.fromJson(v));
      });
    }

    if (json['testPreparations'] != null) {
      testPreparations = [];
      json['testPreparations'].forEach((v) {
        testPreparations?.add(TestPreparation.fromJson(v));
      });
    }

    isPhoneActivated = json['isPhoneActivated'] ?? false;
    timezone = json['timezone'] ?? 0;

    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(FeedBack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data["google"] = google;
    data["facebook"] = facebook;
    data["apple"] = apple;
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['phone'] = phone;
    data['roles'] = roles;
    data['language'] = language;
    data['birthday'] = birthday;
    data['isActivated'] = isActivated;
    data['walletInfo'] = walletInfo?.toJson();
    data['courses'] = courses; //.map((v) => v.toJson()).toList();
    data['requireNote'] = requireNote;
    data['level'] = level;
    data['learnTopics'] = learnTopics?.map((v) => v.toJson()).toList();
    data['testPreparations'] =
        testPreparations?.map((v) => v.toJson()).toList();
    data['isPhoneActivated'] = isPhoneActivated;
    data['timezone'] = timezone;
    data['feedbacks'] = feedbacks?.map((v) => v.toJson()).toList();
    return data;
  }
}
