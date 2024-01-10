import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/services/schedule_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_alert_dialog/custom_accept_dialog.dart';
import 'package:lettutor_flutter/widgets/custom_alert_dialog/custom_two_btn_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpComingCard extends StatelessWidget {
  const UpComingCard({Key? key, required this.upcomming, required this.refetch})
      : super(key: key);

  final BookingInfo upcomming;
  final Function(String) refetch;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final base64Decoded = base64.decode(base64.normalize(
        upcomming.studentMeetingLink.split("token=")[1].split(".")[1]));
    final urlObject = utf8.decode(base64Decoded);
    final jsonRes = json.decode(urlObject);
    final String roomId = jsonRes['room'];
    final String tokenMeeting = upcomming.studentMeetingLink.split("token=")[1];

    final lang = Provider.of<AppProvider>(context).language;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10000),
                          child: CachedNetworkImage(
                            imageUrl: upcomming.scheduleDetailInfo!
                                .scheduleInfo!.tutorInfo!.avatar as String,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          upcomming.scheduleDetailInfo!.scheduleInfo!.tutorInfo!
                              .name,
                          style: BaseTextStyle.heading2(fontSize: 16),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMEd().format(
                                DateTime.fromMillisecondsSinceEpoch(upcomming
                                    .scheduleDetailInfo!.startPeriodTimestamp)),
                            style: const TextStyle(fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 1),
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(upcomming
                                      .scheduleDetailInfo!
                                      .startPeriodTimestamp)),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.blue),
                            ),
                          ),
                          const Text("-"),
                          Container(
                            padding: const EdgeInsets.all(3),
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.orange, width: 1),
                                color: Colors.orange[50],
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat.Hm().format(
                                  DateTime.fromMillisecondsSinceEpoch(upcomming
                                      .scheduleDetailInfo!.endPeriodTimestamp)),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.orange),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAcceptDialog(
                                content: lang.cancelUpcomingWarning,
                                context: context,
                                acceptFuction: () async {
                                  final now = DateTime.now();
                                  final start =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          upcomming.scheduleDetailInfo!
                                              .startPeriodTimestamp);
                                  if (start.isAfter(now) &&
                                      now.difference(start).inHours.abs() >=
                                          2) {
                                    final res =
                                        await ScheduleService.cancelClass(
                                            authProvider.tokens!.access.token,
                                            upcomming.id);
                                    if (res) {
                                      refetch(
                                          authProvider.tokens!.access.token);
                                      // ignore: use_build_context_synchronously
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message: lang.removeUpcomingSuccess,
                                          backgroundColor: Colors.green,
                                        ),
                                        showOutAnimationDuration:
                                            const Duration(milliseconds: 700),
                                        displayDuration:
                                            const Duration(milliseconds: 200),
                                      );
                                    }
                                  } else {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                          message: lang.removeUpcomingFail),
                                      showOutAnimationDuration:
                                          const Duration(milliseconds: 700),
                                      displayDuration:
                                          const Duration(milliseconds: 200),
                                    );
                                  }
                                },
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300] as Color),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                bottomLeft: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.cancel,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (isVisibleMeetingBtn(upcomming)) {
                            var options = JitsiMeetingOptions(
                              roomNameOrUrl: roomId,
                              serverUrl: "https://meet.lettutor.com",
                              isAudioOnly: true,
                              isAudioMuted: true,
                              token: tokenMeeting,
                              isVideoMuted: true);

                          await JitsiMeetWrapper.joinMeeting(options: options);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: isVisibleMeetingBtn(upcomming)
                                    ? Colors.blue
                                    : Colors.grey[200] as Color),
                            color: isVisibleMeetingBtn(upcomming)
                                ? Colors.blue
                                : Colors.grey[200] as Color,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              lang.goToMeeting,
                              style: TextStyle(
                                  color: isVisibleMeetingBtn(upcomming)
                                      ? Colors.white
                                      : Colors.grey[500] as Color),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

bool isVisibleMeetingBtn(BookingInfo bookingInfo) {
  final now = DateTime.now();
  final start = DateTime.fromMillisecondsSinceEpoch(
      bookingInfo.scheduleDetailInfo!.startPeriodTimestamp);
  return (now.day == start.day &&
      now.month == start.month &&
      now.year == start.year);
}
