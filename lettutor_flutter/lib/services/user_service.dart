// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/models/user_model/learning_topic_model.dart';
import 'package:lettutor_flutter/models/user_model/test_preparation_model.dart';
import 'package:lettutor_flutter/models/user_model/user_model.dart';

class UserService {
  static const String url = 'https://sandbox.api.lettutor.com';
  //static Tokens? tokens;

  static User parseUser(String responseBody) {
    final parsed = json.decode(responseBody);
    return User.fromJson(parsed);
  }

  static Future<List<LearnTopic>> fetchAllLearningTopic(String token) async {
    final response = await http.get(
      Uri.parse('$url/learn-topic'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTopics = jsonRes.map((e) => LearnTopic.fromJson(e)).toList();
      return allTopics;
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static Future<List<TestPreparation>> fetchAllTestPreparation(
      String token) async {
    final response = await http.get(
      Uri.parse('$url/test-preparation'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body) as List;
      final allTestPreparation =
          jsonRes.map((e) => TestPreparation.fromJson(e)).toList();
      return allTestPreparation;
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static addAndRemoveTutorFavorite(String tutorId, String token) async {
    print("Token: $token");
    print("TutorId: $tutorId");
    final response = await http.post(
      Uri.parse('$url/user/manageFavoriteTutor'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'tutorId': tutorId,
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static getTotalHourLesson(String token) async {
    final response = await http.get(
      Uri.parse('$url/call/total'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      return jsonRes["total"];
    } else {
      return null;
    }
  }

  static Future<BookingInfo?> fetchNextLesson(String token) async {
    final dateTime = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(
      Uri.parse('$url/booking/next?dateTime=$dateTime'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final listData = jsonRes["data"] as List;
      List<BookingInfo> arrLesson =
          listData.map((e) => BookingInfo.fromJson(e)).toList();
      arrLesson.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp
          .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp));

      arrLesson = arrLesson
          .where((element) =>
              element.scheduleDetailInfo!.startPeriodTimestamp > dateTime)
          .toList();
      if (arrLesson.isEmpty) {
        return null;
      } else {
        return arrLesson.first;
      }
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static Future<User?> updateInfo(
      String token,
      String name,
      String country,
      String birthday,
      String level,
      List<String> learnTopics,
      List<String> testPreparations) async {
    Map<String, dynamic> args = {
      'name': name,
      'country': country,
      'birthday': birthday,
      'level': level,
      'learnTopics': learnTopics,
      'testPreparations': testPreparations,
    };
    final response = await http.put(
      Uri.parse('$url/user/info'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;encoding=utf-8',
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final user = User.fromJson(jsonRes["user"]);
      return user;
    } else {
      return null;
    }
  }

  static Future<User?> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$url/user/info'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json;encoding=utf-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final user = User.fromJson(jsonRes["user"]);
      return user;
    } else {
      return null;
    }
  }

  static changePassword(
      String token, String password, String newPassword) async {
    final response = await http.post(
      Uri.parse('$url/auth/change-password'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'password': password,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static Future<bool> uploadAvatar(String path, String token) async {
    final request =
        http.MultipartRequest("POST", Uri.parse('$url/user/uploadAvatar'));

    final img = await http.MultipartFile.fromPath("avatar", path);

    request.files.add(img);
    request.headers.addAll({"Authorization": 'Bearer $token'});

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
