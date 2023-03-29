import 'package:lettutor_flutter/models/user_model/feedback_model.dart';

class TutorInfo {
  String? level;
  late String email;
  String? google;
  String? facebook;
  String? apple;
  String? avatar;
  late String name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  late bool requestPassword;
  late bool isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  late bool isPhoneAuthActivated;
  late String createdAt;
  late String updatedAt;
  String? deletedAt;
  late List<FeedBack> feedbacks;
  late String id;
  late String userId;
  late String video;
  late String bio;
  late String education;
  late String experience;
  late String profession;
  String? accent;
  late String targetStudent;
  late String interests;
  late String languages;
  late String specialties;
  String? resume;
  bool? isNative;
  late int price;
  bool? isOnline;

  TutorInfo({
    required this.level,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.avatar,
    required this.name,
    this.country,
    required this.phone,
    this.language,
    this.birthday,
    required this.requestPassword,
    required this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    required this.isPhoneAuthActivated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.feedbacks,
    required this.id,
    required this.userId,
    required this.video,
    required this.bio,
    required this.education,
    required this.experience,
    required this.profession,
    this.accent,
    required this.targetStudent,
    required this.interests,
    required this.languages,
    required this.specialties,
    this.resume,
    this.isNative,
    required this.price,
    this.isOnline,
  });

  TutorInfo.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['feedbacks'] != null) {
      feedbacks = [];
      json['feedbacks'].forEach((v) {
        feedbacks.add(FeedBack.fromJson(v));
      });
    }
    id = json['id'];
    userId = json['userId'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    resume = json['resume'];
    isNative = json['isNative'];
    price = json['price'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['level'] = level;
    data['email'] = email;
    data['google'] = google;
    data['facebook'] = facebook;
    data['apple'] = apple;
    data['avatar'] = avatar;
    data['name'] = name;
    data['country'] = country;
    data['phone'] = phone;
    data['language'] = language;
    data['birthday'] = birthday;
    data['requestPassword'] = requestPassword;
    data['isActivated'] = isActivated;
    data['isPhoneActivated'] = isPhoneActivated;
    data['requireNote'] = requireNote;
    data['timezone'] = timezone;
    data['phoneAuth'] = phoneAuth;
    data['isPhoneAuthActivated'] = isPhoneAuthActivated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['feedbacks'] = feedbacks.map((v) => v.toJson()).toList();
    data['id'] = id;
    data['userId'] = userId;
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
    data['isNative'] = isNative;
    data['price'] = price;
    data['isOnline'] = isOnline;
    return data;
  }
}
