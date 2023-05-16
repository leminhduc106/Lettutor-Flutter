import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/models/schedule_model/schedule_model.dart';

class ScheduleService {
  static const String url = "https://sandbox.api.lettutor.com";

  static Future<List<Schedule>> getTutorSchedule(
      String tutorId, String token) async {
    final response = await http.post(Uri.parse("$url/schedule"), headers: {
      "Authorization": "Bearer $token",
    }, body: {
      "tutorId": tutorId,
    });

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final listSchedule = res["data"] as List;
      return listSchedule
          .map((schedule) => Schedule.fromJson(schedule))
          .toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  static Future<List<BookingInfo>> getStudentBookedClass(
      int page, int perPage, String studentId, String token) async {
    final current = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(
      Uri.parse(
          "$url/booking/list/student?page=$page&perPage=$perPage&dateTimeLte=$current&orderBy=meeting&sortBy=desc"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final listBooked = res["data"]["rows"] as List;
      final arr =
          listBooked.map((schedule) => BookingInfo.fromJson(schedule)).toList();
      return arr;
    } else {
      throw Exception('Failed to load booking history');
    }
  }

  static Future<List<BookingInfo>> getUpcomming(
      int page, int perPage, String token) async {
    final current = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(
      Uri.parse(
          "$url/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$current&orderBy=meeting&sortBy=asc"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final listBooked = res["data"]["rows"] as List;
      final arr =
          listBooked.map((schedule) => BookingInfo.fromJson(schedule)).toList();
      return arr;
    } else {
      throw Exception('Failed to load upcomming lesson');
    }
  }

  static Future<bool> cancelClass(
      String token, String scheduleDetailIds) async {
    Map<String, List<String>> args = {
      "scheduleDetailIds": [scheduleDetailIds],
    };

    final response = await http.delete(
      Uri.parse("$url/booking"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode(args),
    );

    print("Delete response status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cancel class');
    }
  }

  static bookAClass(String scheduleDetailIds, String token) async {
    final List<String> list = [scheduleDetailIds];
    final Map<String, dynamic> args = {
      "scheduleDetailIds": list,
    };

    final response = await http.post(
      Uri.parse("$url/booking"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json;encoding=utf-8",
      },
      body: json.encode(args),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }
}
