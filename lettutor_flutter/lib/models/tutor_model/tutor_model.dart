// ignore_for_file: avoid_print

import 'package:lettutor_flutter/models/user_model/user_model.dart';

class Tutor {
  String? video;
  late String bio;
  late String education;
  late String experience;
  late String profession;
  String? accent;

  String? targetStudent;
  late String interests;
  late String languages;
  late String specialties;
  String? rating;
  bool? isNative;

  late User user;

  String? resume;
  late bool isActivated;
  late String createdAt;
  late String updatedAt;
  bool? isFavorite;
  int? avgRating;

  late int totalFeedback;
  String? name;
  String? avatar;

  Tutor({
    this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    required this.user,
    this.accent,
    this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    this.resume,
    required this.isActivated,
    this.isNative,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite,
    this.avgRating,
    required this.totalFeedback,
  });

  Tutor.fromJson(Map<String, dynamic> json) {
    video = json['video'] ?? "";
    bio = json['bio'] ?? "";
    education = json['education'] ?? "";
    experience = json['experience'] ?? "";
    profession = json['profession'] ?? "";
    accent = json['accent'] ?? "";
    targetStudent = json['targetStudent'] ?? "";
    interests = json['interests'] ?? "";
    languages = json['languages'] ?? "";
    specialties = json['specialties'] ?? "";
    resume = json['resume'] ?? "";
    isActivated = json['isActivated'] ?? false;
    isNative = json['isNative'] ?? false;
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    isFavorite = json['isFavorite'] ?? false;
    avgRating = json['avgRating'] != null ? json['avgRating'].toInt() : 0;
    totalFeedback = json['totalFeedback'] ?? 0;
    user = (json["User"] != null ? User.fromJson(json['User']) : null)!;
    name = json['name'];
    avatar = json['avatar'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['video'] = video;
    data['bio'] = bio;
    data['education'] = education;
    data['experience'] = experience;
    data['profession'] = profession;
    data['accent'] = accent;
    data['targetStudent'] = targetStudent;
    data['interests'] = interests;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['resume'] = resume;
    data['isActivated'] = isActivated;
    data['isNative'] = isNative;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isFavorite'] = isFavorite;
    data['avgRating'] = avgRating;
    data['totalFeedback'] = totalFeedback;
    data['user'] = user.toJson();
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
