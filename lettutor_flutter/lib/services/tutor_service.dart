// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor_flutter/models/tutor_model/tutor_info_model.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_model.dart';

class TutorService {
  static const String url = "https://sandbox.api.lettutor.com";

  static Tutor parseTutor(String responseBody) {
    final parsed = json.decode(responseBody);
    return Tutor.fromJson(parsed);
  }

  static Future<List<TutorInfo>> getListTutorWithPagination(
      int page, int perPage, String token) async {
    final response = await http.get(
      Uri.parse('$url/tutor/more?perPage=$perPage&page=$page'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      final List<dynamic> listTutor = jsonDecode['tutors']["rows"];
      return listTutor.map((tutor) => TutorInfo.fromJson(tutor)).toList();
    } else {
      final jsonDecode = json.decode(response.body);
      print(jsonDecode);
      throw Exception(jsonDecode['message']);
    }
  }

  static getTutor(String id, String token) async {
    final response = await http.get(
      Uri.parse('$url/tutor/$id'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      return Tutor.fromJson(jsonDecode);
    } else {
      final jsonDecode = json.decode(response.body);
      print(jsonDecode);
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<List<TutorInfo>> searchTutor(
    int page,
    int perPage,
    String token, {
    String search = "",
    List<String> specialties = const [],
  }) async {
    final Map<String, dynamic> args = {
      "page": page,
      "perPage": perPage,
      "search": search,
      "filters": {
        "specialties": specialties,
      },
    };

    final response = await http.post(
      Uri.parse("$url/tutor/search"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final List<dynamic> tutors = jsonRes["rows"];
      return tutors.map((tutor) => TutorInfo.fromJson(tutor)).toList();
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static Future<bool> witeFeedback(String content, String bookingId,
      String userId, int rate, String token) async {
    final response = await http.post(
      Uri.parse("$url/user/feedbackTutor"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode({
        "content": content,
        "bookingId": bookingId,
        "userId": userId,
        "rating": rate,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }
}
