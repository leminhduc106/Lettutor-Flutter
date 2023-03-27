import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/upcoming_page/card_coming.dart';
import 'package:provider/provider.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({Key? key}) : super(key: key);

  @override
  _UpcomingPageState createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    final userUpcomming =
        Provider.of<UserProvider>(context).user.getUpcomming();
    userUpcomming.sort((a, b) => a.start.compareTo(b.start));
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 112,
              child: Image.asset(
                "assets/icons/common/icon_schedule.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Booked Schedule",
                style: BaseTextStyle.heading4(),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
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
                "Here is a list of the sessions you have booked. You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours.",
                style: BaseTextStyle.body1(fontSize: 14),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            userUpcomming.isNotEmpty
                ? ListView.separated(
                    itemCount: userUpcomming.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return UpComingCard(upcomming: userUpcomming[index]);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/ic_empty.svg",
                            width: 200,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              "You don't have any upcomming...",
                              style: BaseTextStyle.body2(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
