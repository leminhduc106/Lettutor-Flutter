import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/schedule_model/booking_info_model.dart';

import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({Key? key, required this.session}) : super(key: key);

  final BookingInfo session;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<AppProvider>(context).language;

    return Card(
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: CachedNetworkImage(
                          imageUrl: session.scheduleDetailInfo!.scheduleInfo!
                              .tutorInfo!.avatar as String,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        session
                            .scheduleDetailInfo!.scheduleInfo!.tutorInfo!.name,
                        style: BaseTextStyle.heading2(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset(
                                "assets/svg/ic_calendar.svg",
                                width: 15),
                          ),
                          Text(
                            DateFormat.yMEd().add_jm().format(
                                DateTime.fromMillisecondsSinceEpoch(session
                                    .scheduleDetailInfo!.startPeriodTimestamp)),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset("assets/svg/ic_clock.svg",
                                width: 20),
                          ),
                          Text(
                            "${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(session.scheduleDetailInfo!.startPeriodTimestamp))} - ${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(session.scheduleDetailInfo!.endPeriodTimestamp))}",
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset("assets/svg/ic_score.svg",
                                width: 15),
                          ),
                          Text(
                            lang.mark +
                                (session.scoreByTutor != null
                                    ? session.scoreByTutor.toString()
                                    : lang.tutorNotMark),
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, routes.feedbackPage,
                          arguments: {"bookingInfo": session});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0070F3)),
                          color: const Color(0xff0070F3),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            lang.giveFeedback,
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, routes.recordVideoPage,
                          arguments: {"url": session.recordUrl ?? ""});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff0070F3)),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            lang.watchRecord,
                            style: const TextStyle(color: Color(0xff0070F3)),
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
    );
  }
}
