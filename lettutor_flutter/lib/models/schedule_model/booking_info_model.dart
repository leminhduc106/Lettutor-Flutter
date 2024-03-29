import 'package:lettutor_flutter/models/schedule_model/schedule_detail_model.dart';

class BookingInfo {
  late int createdAtTimeStamp;
  late int updatedAtTimeStamp;
  late String id;
  late String userId;
  late String scheduleDetailId;
  late String tutorMeetingLink;
  late String studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  late String createdAt;
  late String updatedAt;
  String? recordUrl;
  late bool isDeleted;
  bool showRecordUrl = true;
  List<String> studentMaterials = [];
  ScheduleDetails? scheduleDetailInfo;

  BookingInfo({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    this.recordUrl,
    required this.isDeleted,
    required this.showRecordUrl,
    required this.studentMaterials,
    this.scheduleDetailInfo,
  });

  BookingInfo.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    studentRequest = json['studentRequest'] ?? "";
    tutorReview = json['tutorReview'] ?? "";
    scoreByTutor = json['scoreByTutor'] ?? 0;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recordUrl = json['recordUrl'] ?? "";
    isDeleted = json['isDeleted'];
    showRecordUrl = json["showRecordUrl"] ?? true;
    studentMaterials = json["studentMaterials"] != null
        ? json["studentMaterials"].cast<String>()
        : [];
    scheduleDetailInfo = json["scheduleDetailInfo"] != null
        ? ScheduleDetails.fromJson(json["scheduleDetailInfo"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['createdAtTimeStamp'] = createdAtTimeStamp;
    data['updatedAtTimeStamp'] = updatedAtTimeStamp;
    data['id'] = id;
    data['userId'] = userId;
    data['scheduleDetailId'] = scheduleDetailId;
    data['tutorMeetingLink'] = tutorMeetingLink;
    data['studentMeetingLink'] = studentMeetingLink;
    data['studentRequest'] = studentRequest;
    data['tutorReview'] = tutorReview;
    data['scoreByTutor'] = scoreByTutor;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['recordUrl'] = recordUrl;
    data['isDeleted'] = isDeleted;
    data['showRecordUrl'] = showRecordUrl;
    data['studentMaterials'] = studentMaterials;
    data['scheduleDetailInfo'] =
        scheduleDetailInfo != null ? scheduleDetailInfo!.toJson() : null;
    return data;
  }
}
