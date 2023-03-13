import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class HistoryLessonPage extends StatefulWidget {
  const HistoryLessonPage({Key? key}) : super(key: key);

  @override
  State<HistoryLessonPage> createState() => _HistoryLessonPageState();
}

class _HistoryLessonPageState extends State<HistoryLessonPage> {
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
    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                  "Lịch sử các buổi học",
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
                  "Đây là danh sách các bài học bạn đã tham gia. Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia.",
                  style: BaseTextStyle.body1(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildHistoryLesson(safeWidth);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 12,
                    ),
                    itemCount: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildHistoryLesson(double safeWidth) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    decoration: BoxDecoration(
        color: BaseColor.lightGrey,
        border: Border.all(color: Colors.black12, width: 0.1),
        boxShadow: [
          BoxShadow(
              color: const Color(0xff003399).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ]),
    width: safeWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "T6, 10 Thg 03 23",
          style: BaseTextStyle.heading4(fontSize: 20),
        ),
        Text(
          "1 ngày trước",
          style: BaseTextStyle.body2(fontSize: 14),
        ),
        _buildTutorInfor(safeWidth),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
          width: safeWidth,
          child: Text(
            "Thời gian bài học: 23:00 - 00:55",
            style: BaseTextStyle.heading2(fontSize: 16),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
          width: safeWidth,
          child: Text(
            "Không có yêu cầu cho buổi học",
            style: BaseTextStyle.heading2(fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 2),
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
          width: safeWidth,
          child: Text(
            "Gia sư chưa có đánh giá",
            style: BaseTextStyle.heading2(fontSize: 14),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 0.1),
            ),
            width: safeWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Đánh giá",
                      style: BaseTextStyle.heading2(
                          fontSize: 14, color: Colors.blue),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Báo cáo",
                      style: BaseTextStyle.heading2(
                          fontSize: 14, color: Colors.blue),
                    )),
              ],
            )),
      ],
    ),
  );
}

Widget _buildTutorInfor(double safeWidth) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 22),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black12, width: 0.1),
    ),
    width: safeWidth,
    child: Row(
      children: [
        const CircleAvatar(
          radius: 38,
          backgroundImage: AssetImage("assets/images/teacher.png"),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Keegan",
              style: BaseTextStyle.heading2(fontSize: 20),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(
                height: 28,
                child: Image.asset(
                  "assets/icons/social/icon_vietnam_flag.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Vietnam",
                style: BaseTextStyle.body2(fontSize: 14),
              ),
            ]),
            Row(
              children: [
                SizedBox(
                  height: 28,
                  child: Image.asset(
                    "assets/icons/action/icon_message.png",
                    fit: BoxFit.fitHeight,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Nhắn tin",
                  style: BaseTextStyle.body2(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
