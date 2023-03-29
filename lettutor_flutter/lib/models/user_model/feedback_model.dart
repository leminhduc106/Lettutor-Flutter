class FeedBack {
  late String id;
  String? bookingId;
  late String firstId;
  late String secondId;
  late int rating;
  late String content;
  late String createdAt;
  late String updatedAt;
  late FirstInfo firstInfo;

  FeedBack(
      {required this.id,
      this.bookingId,
      required this.firstId,
      required this.secondId,
      required this.rating,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.firstInfo});

  FeedBack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    if (json["rating"].runtimeType == int) {
      rating = json['rating'];
    } else {
      rating = json['rating'].toInt() ?? 5;
    }
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    firstInfo = FirstInfo.fromJson(json['firstInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['firstId'] = firstId;
    data['secondId'] = secondId;
    data['rating'] = rating;
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['firstInfo'] = firstInfo.toJson();
    return data;
  }
}

class FirstInfo {
  String? id;
  late String email;
  String? google;
  String? facebook;
  String? apple;
  late String name;
  late String avatar;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? isActivated;
  String? level;
  bool? requestPassword;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  late String createdAt;
  late String updatedAt;
  String? deletedAt;

  FirstInfo({
    this.id,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.name,
    required this.avatar,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.isActivated,
    this.level,
    this.requestPassword,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  FirstInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    level = json['level'];
    requestPassword = json['requestPassword'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['email'] = email;
    data['google'] = google;
    data['facebook'] = facebook;
    data['apple'] = apple;
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['phone'] = phone;
    data['language'] = language;
    data['birthday'] = birthday;
    data['isActivated'] = isActivated;
    data['level'] = level;
    data['requestPassword'] = requestPassword;
    data['isPhoneActivated'] = isPhoneActivated;
    data['requireNote'] = requireNote;
    data['timezone'] = timezone;
    data['phoneAuth'] = phoneAuth;
    data['isPhoneAuthActivated'] = isPhoneAuthActivated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    return data;
  }
}
