import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor_flutter/provider/navigation_index.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class BannerHomePage extends StatelessWidget {
  const BannerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context).user;
    final navigationIndex = Provider.of<NavigationIndex>(context);
    final upcomming = userProvider.getUpcomming();
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);

    if (upcomming.isEmpty) {
      return Container(
        color: BaseColor.blue,
        width: size.width,
        height: size.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Chào mừng đến với LetTutor',
                style:
                    BaseTextStyle.heading3(color: Colors.white, fontSize: 22)),
            Container(
              margin: const EdgeInsets.only(top: 32.0),
              width: safeWidth * 0.5,
              child: CustomButton.whiteBtnWithIcon(
                  onTap: () {
                    navigationIndex.index = 3;
                  },
                  content: "Đặt lịch học",
                  iconPath: "assets/icons/social/icon_youtube.png"),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width,
      color: const Color(0xff0040D6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Tổng số giờ bạn đã học là ${getFormatTotalTime(userProvider.getTotalLessonTime())}",
            style: BaseTextStyle.heading5(color: Colors.white, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              "Buổi học sắp diễn ra",
              style: BaseTextStyle.heading3(color: Colors.white),
            ),
          ),
          Text(
            stringFormatUpcomming(userProvider.getNearestLesson()?.start,
                userProvider.getNearestLesson()?.end),
            style: const TextStyle(fontSize: 13, color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32.0),
            width: safeWidth * 0.5,
            child: CustomButton.whiteBtnWithIcon(
                onTap: () {
                  Navigator.pushNamed(context, routes.lessonPage);
                },
                content: "Vào lớp học",
                iconPath: "assets/icons/social/icon_youtube.png"),
          ),
        ],
      ),
    );
  }
}

String getFormatTotalTime(int m) {
  final days = (m / 60 / 24).floor();
  final hours = (m % (60 * 24) / 60).floor();
  final minutes = m % 60;

  String res = "";

  if (days > 0) {
    res += "$days days ";
  }
  if (hours > 0) {
    res += "$hours hours ";
  }
  if (minutes > 0) {
    res += "$minutes minutes ";
  }
  return res;
}

String stringFormatUpcomming(DateTime? s, DateTime? e) {
  if (s == null || e == null) {
    return "";
  }
  return DateFormat.yMEd().format(s) +
      " " +
      DateFormat.jm().format(s) +
      " - " +
      DateFormat.jm().format(e);
}
