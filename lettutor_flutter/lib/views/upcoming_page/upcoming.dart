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

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: userUpcomming.isNotEmpty
            ? ListView.builder(
                itemCount: userUpcomming.length,
                itemBuilder: (context, index) {
                  return UpComingCard(upcomming: userUpcomming[index]);
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
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
      ),
    );
  }
}
