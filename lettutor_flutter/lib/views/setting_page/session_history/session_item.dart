import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/models/user/session.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:provider/provider.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({Key? key, required this.session}) : super(key: key);

  final Session session;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    bool checkFeebacked() {
      if (session.tutor.feedbacks
          .where((element) => element.userId == user.id)
          .isNotEmpty) return true;
      return false;
    }

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
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: AvatarCircle(
                        width: 55, height: 55, source: session.tutor.image)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        session.tutor.fullName,
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
                            DateFormat.yMEd().add_jm().format(session.start),
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
                            Duration(seconds: session.duration)
                                .toString()
                                .split('.')
                                .first
                                .padLeft(8, "0"),
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
                            child: SvgPicture.asset("assets/svg/ic_star2.svg",
                                width: 20),
                          ),
                          checkFeebacked() == false
                              ? const Text(
                                  "Not feedback yet",
                                  style: TextStyle(fontSize: 13),
                                )
                              : Text(
                                  session.tutor.feedbacks
                                      .where((element) =>
                                          element.userId == user.id)
                                      .first
                                      .rating
                                      .toString(),
                                )
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
                          arguments: {"tutor": session.tutor});
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
                        children: const <Widget>[
                          Text(
                            "Give Feedback",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
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
                      children: const <Widget>[
                        Text(
                          "See Tutor Detail",
                          style: TextStyle(color: Color(0xff0070F3)),
                        )
                      ],
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
