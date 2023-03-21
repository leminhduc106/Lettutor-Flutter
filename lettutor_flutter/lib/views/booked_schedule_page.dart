import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';

class BookedSchedulePage extends StatefulWidget {
  const BookedSchedulePage({Key? key}) : super(key: key);

  @override
  State<BookedSchedulePage> createState() => _BookedSchedulePageState();
}

class _BookedSchedulePageState extends State<BookedSchedulePage> {
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
                height: 112,
                child: Image.asset(
                  "assets/icons/common/icon_schedule.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Lịch đã đặt",
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
                  "Đây là danh sách những khung giờ bạn đã đặt. Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.",
                  style: BaseTextStyle.body1(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              _buildLessonInfor(safeWidth),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildLessonInfor(double safeWidth) {
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
          "4 buổi học liên tục",
          style: BaseTextStyle.body2(fontSize: 14),
        ),
        _buildTutorInfor(safeWidth),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.1),
          ),
          width: safeWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thời gian bài học: 23:00 - 00:55",
                style: BaseTextStyle.heading2(fontSize: 16),
              ),
              const SizedBox(height: 12),
              _buildLessonTimeInfor(
                  safeWidth: safeWidth, lessonTime: "Buổi 1: 23:00 - 23:55"),
              const SizedBox(height: 12),
              _buildLessonTimeInfor(
                  safeWidth: safeWidth, lessonTime: "Buổi 2: 23:00 - 23:55"),
              const SizedBox(height: 12),
              _buildLessonTimeInfor(
                  safeWidth: safeWidth, lessonTime: "Buổi 3: 00:00 - 00:25"),
              const SizedBox(height: 12),
              _buildLessonTimeInfor(
                  safeWidth: safeWidth, lessonTime: "Buổi 4: 12:00 - 15:55"),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 14.0),
                  decoration: BoxDecoration(
                    color: BaseColor.lightGrey,
                    border: Border.all(color: Colors.black, width: 0.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios, size: 18),
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Yêu cầu cho buổi học",
                          style: BaseTextStyle.body2(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Chỉnh sửa yêu cầu",
                            style: BaseTextStyle.body3(
                                fontSize: 14, color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: safeWidth * 0.4,
              child: CustomButton.common(
                  onTap: () {}, content: "Vào buổi học", isBorderRadius: false),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLessonTimeInfor(
    {required double safeWidth, required String lessonTime}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        lessonTime,
        style: BaseTextStyle.body2(fontSize: 16),
      ),
      SizedBox(
        width: safeWidth * 0.26,
        child: CustomButton.whiteBtnWithIcon(
            onTap: () {},
            outlineColor: Colors.red,
            textColor: Colors.red,
            isBorderRadius: false,
            content: "Hủy",
            iconPath: "assets/icons/action/icon_cancel.png"),
      ),
    ],
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
