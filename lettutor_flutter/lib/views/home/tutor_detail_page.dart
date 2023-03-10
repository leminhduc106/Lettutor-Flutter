import 'dart:math';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/video_player/video_player.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({Key? key}) : super(key: key);

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  double _rating = 88;
  bool _isExpanded = false;
  int maxLength = 100;
  List<String> _tutorItems = [
    'Tiếng Anh cho công việc',
    'Giao tiếp',
    'IELTS',
    'TOEIC'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    String text =
        'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around the world.';
    if (!_isExpanded && text.length > maxLength) {
      text = text.substring(0, maxLength) + "...";
    }

    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundImage: AssetImage("assets/images/teacher.png"),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Keegan",
                        style: BaseTextStyle.heading2(fontSize: 22),
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 24,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            ignoreGestures: true,
                            onRatingUpdate: (double value) {},
                          ),
                          Text(
                            "(${_rating.toStringAsFixed(0)})",
                            style: BaseTextStyle.body1(),
                          ),
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 32,
                              child: Image.asset(
                                "assets/icons/social/icon_vietnam_flag.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Vietnam",
                              style: BaseTextStyle.body3(),
                            ),
                          ]),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 24),
              _isExpanded
                  ? Text(
                      text,
                      style: BaseTextStyle.body2(
                          fontSize: 14, color: Colors.black54),
                    )
                  : Text(
                      text,
                      style: BaseTextStyle.body2(
                          fontSize: 14, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
              if (text.length > maxLength)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Text(
                    _isExpanded ? "less" : "more",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTutorUtilities(
                    icon: Icons.favorite_border_outlined,
                    text: "Yêu thích",
                    onPressed: () {},
                  ),
                  _buildTutorUtilities(
                    icon: Icons.report_outlined,
                    text: "Báo cáo",
                    onPressed: () {},
                  ),
                  _buildTutorUtilities(
                      icon: Icons.star_border_outlined,
                      text: "Xem đánh giá",
                      onPressed: () {}),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                color: Colors.transparent,
                width: safeWidth,
                height: heightSafeArea * 0.3,
                child: VideoPlayerPage(),
              ),
              const SizedBox(height: 18),
              _buildTutorInfor(_tutorItems),
              const SizedBox(height: 18),
              // Expanded(
              //   child: SfCalendar(
              //     view: CalendarView.week,

              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildTutorInfor(List<String> tutorItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Ngôn ngữ",
        style: BaseTextStyle.heading2(fontSize: 18),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 227, 247),
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Text("English",
            style: BaseTextStyle.body2(fontSize: 14, color: Colors.blue)),
      ),
      Text(
        "Chuyên ngành",
        style: BaseTextStyle.heading2(fontSize: 18),
      ),
      const SizedBox(height: 16),
      Wrap(
        spacing: 10.0,
        runSpacing: 14.0,
        children: tutorItems.map<Widget>((item) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 208, 227, 247),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Text(item,
                  style: BaseTextStyle.body2(fontSize: 14, color: Colors.blue)),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 24),
      Text(
        "Khóa học tham khảo",
        style: BaseTextStyle.heading2(fontSize: 18),
      ),
      const SizedBox(height: 8),
      Row(children: [
        Text(
          "Basic Conversation Topics:",
          style: BaseTextStyle.heading4(fontSize: 16),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Tìm hiểu",
            style: BaseTextStyle.heading2(fontSize: 14, color: Colors.blue),
          ),
        ),
      ]),
      Row(children: [
        Text(
          "Life in the Internet Age:",
          style: BaseTextStyle.heading4(fontSize: 16),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Tìm hiểu",
            style: BaseTextStyle.heading2(fontSize: 14, color: Colors.blue),
          ),
        ),
      ]),
      const SizedBox(height: 24),
      Text(
        "Sở thích",
        style: BaseTextStyle.heading2(fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text(
        "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
        style: BaseTextStyle.body2(fontSize: 14, color: Colors.black54),
      ),
      const SizedBox(height: 24),
      Text(
        "Kinh nghiệm giảng dạy",
        style: BaseTextStyle.heading2(fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text(
        "I have more than 10 years of teaching English experience.",
        style: BaseTextStyle.body2(fontSize: 14, color: Colors.black54),
      ),
    ],
  );
}

Widget _buildTutorUtilities(
    {required IconData icon,
    required String text,
    required Function() onPressed}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.blue,
            size: 32,
          )),
      Text(
        text,
        style: BaseTextStyle.body2(fontSize: 14, color: Colors.blue),
      ),
    ],
  );
}
