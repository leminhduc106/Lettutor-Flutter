import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/session_history/session_item.dart';
import 'package:provider/provider.dart';

class SessionHistoryPage extends StatelessWidget {
  const SessionHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);

    final sessionHistory =
        Provider.of<UserProvider>(context).user.sessionHistory;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[800]),
          title: Text(
            "Session History",
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 104,
                  child: Image.asset(
                    "assets/icons/common/icon_history.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "History",
                    style: BaseTextStyle.heading4(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: Colors.black12, width: 0.1),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 6, 11, 21)
                                .withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: const Offset(0, 0))
                      ]),
                  width: safeWidth,
                  child: Text(
                    "The following is a list of lessons you have attended. You can review the details of the lessons you have attended.",
                    style: BaseTextStyle.body1(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 18,
                  ),
                  itemCount: sessionHistory.length,
                  itemBuilder: (context, index) => SessionItem(
                    session: sessionHistory[index],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
