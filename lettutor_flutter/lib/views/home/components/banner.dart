import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/global_state/navigation_index.dart';
import 'package:lettutor_flutter/models/language_model/language.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';
import 'package:lettutor_flutter/services/user_service.dart';

import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class BannerHomePage extends StatefulWidget {
  const BannerHomePage({Key? key}) : super(key: key);

  @override
  State<BannerHomePage> createState() => _BannerHomePageState();
}

class _BannerHomePageState extends State<BannerHomePage> {
  Duration? totalLessonTime;
  BookingInfo? nextlesson;
  int? timeStamp;
  bool isLoading = true;

  void fetchTotalLessonTime(String token) async {
    final res = await UserService.getTotalHourLesson(token);
    final next = await UserService.fetchNextLesson(token);
    if (res != null && mounted) {
      setState(() {
        timeStamp = res;
        nextlesson = next;
        totalLessonTime = Duration(minutes: res);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);

    final navigationIndex = Provider.of<NavigationIndex>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

    if (isLoading && authProvider.tokens != null) {
      fetchTotalLessonTime(authProvider.tokens?.access.token as String);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      color: BaseColor.blue,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeStamp != 0 && totalLessonTime != null
                      ? "${lang.totalLessonTime} ${covertTotalTime(totalLessonTime as Duration, lang)} "
                      : lang.wellcome,
                  style:
                      BaseTextStyle.heading2(color: Colors.white, fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                nextlesson != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          lang.nextLesson,
                          style: BaseTextStyle.heading2(
                              color: Colors.white, fontSize: 22),
                        ),
                      )
                    : Container(),
                Text(
                  nextlesson != null
                      ? "${DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(nextlesson!.scheduleDetailInfo!.startPeriodTimestamp))} ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextlesson!.scheduleDetailInfo!.startPeriodTimestamp))} - ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(nextlesson!.scheduleDetailInfo!.endPeriodTimestamp))}"
                      : "",
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.only(bottom: 28.0),
                  width: safeWidth * 0.6,
                  child: CustomButton.whiteBtnWithIcon(
                      onTap: () async {
                        if (nextlesson != null) {
                          final base64Decoded = base64.decode(base64.normalize(
                              nextlesson!.studentMeetingLink
                                  .split("token=")[1]
                                  .split(".")[1]));
                          final urlObject = utf8.decode(base64Decoded);
                          final jsonRes = json.decode(urlObject);
                          final String roomId = jsonRes['room'];
                          final String tokenMeeting =
                              nextlesson!.studentMeetingLink.split("token=")[1];

                          var options = JitsiMeetingOptions(
                              roomNameOrUrl: roomId,
                              serverUrl: "https://meet.lettutor.com",
                              isAudioOnly: true,
                              isAudioMuted: true,
                              token: tokenMeeting,
                              isVideoMuted: true);

                          await JitsiMeetWrapper.joinMeeting(options: options);
                        } else {
                          navigationIndex.index = 3;
                        }
                      },
                      content: nextlesson != null
                          ? lang.enterRoom
                          : lang.bookAlesson,
                      iconPath: "assets/icons/social/icon_youtube.png"),
                ),
              ],
            ),
    );
  }
}

String covertTotalTime(Duration d, Language lang) {
  String res = "";
  Duration total = d;
  if (total.inHours > 0) {
    if (lang.name == "EN") {
      res += "${total.inHours} hours ";
    } else {
      res += "${total.inHours} giờ ";
    }
    total = total - Duration(hours: total.inHours);
  }
  if (total.inMinutes > 0) {
    if (lang.name == "EN") {
      res += "${total.inMinutes} minutes";
    } else {
      res += "${total.inMinutes} phút";
    }
    total = total - Duration(minutes: total.inMinutes);
  }

  return res;
}
