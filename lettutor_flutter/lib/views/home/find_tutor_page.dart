import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';

class FindTutorPage extends StatefulWidget {
  const FindTutorPage({Key? key}) : super(key: key);

  @override
  State<FindTutorPage> createState() => _FindTutorPageState();
}

class _FindTutorPageState extends State<FindTutorPage> {
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
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          height: 24,
          child: Image.asset(
            "assets/icons/social/lettutor_icon.png",
            fit: BoxFit.fitHeight,
          ),
        ),
        title: Text('LetTutor',
            style: BaseTextStyle.heading4(color: BaseColor.secondaryBlue)),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: BaseColor.lightGrey,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(color: BaseColor.blue, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff003399).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ]),
                  child: SizedBox(
                    height: 64,
                    child: Image.asset(
                      "assets/icons/social/icon_vietnam.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: BaseColor.lightGrey,
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(color: BaseColor.blue, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xff003399).withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ]),
                  child: SizedBox(
                    height: 64,
                    child: Image.asset(
                      "assets/icons/common/icon_menu.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              _buildCourseInfor(size, safeWidth),
            ])),
      ),
    );
  }
}

Widget _buildCourseInfor(Size size, double safeWidth) {
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
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Text('Buổi học sắp diễn ra',
              style: BaseTextStyle.heading3(color: Colors.white)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Text('T3, 07 Thg 03 18:30 - 18:55',
              style: BaseTextStyle.heading5(color: Colors.white)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 32.0),
          width: safeWidth * 0.5,
          child: CustomButton.whiteBtnWithIcon(
              onTap: () {}, content: "Vào lớp học"),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Text('Tổng số giờ bạn đã học là 293 giờ 45 phút',
              style: BaseTextStyle.heading5(color: Colors.white, fontSize: 15)),
        ),
      ],
    ),
  );
}
