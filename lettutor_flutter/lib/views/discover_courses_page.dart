import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';

class DiscoverCoursePage extends StatefulWidget {
  const DiscoverCoursePage({Key? key}) : super(key: key);

  @override
  State<DiscoverCoursePage> createState() => _DiscoverCoursePageState();
}

class _DiscoverCoursePageState extends State<DiscoverCoursePage> {
  final _findCourseController = TextEditingController();
  final _levelFilterController = TextEditingController();
  final _categoryFilterController = TextEditingController();

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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 80,
                    child: Image.asset(
                      "assets/icons/common/icon_course.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        child: Text(
                          "Khám phá các khóa học",
                          style: BaseTextStyle.heading4(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: safeWidth * 0.6,
                        child: CustomTextField.common(
                          onChanged: (value) {},
                          textEditingController: _findCourseController,
                          hintText: "Khóa học...",
                          edit: () {},
                          editIconPath: "assets/icons/action/icon_search.png",
                          textInputType: TextInputType.name,
                          fillColor: BaseColor.lightGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
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
                  "LiveTutor đã xây dựng nên các khóa học của các lĩnh vực trong cuộc sống chất lượng, bài bản và khoa học nhất cho những người đang có nhu cầu trau dồi thêm kiến thức về các lĩnh vực.",
                  style: BaseTextStyle.body1(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              _buildFilterCourse(
                  _levelFilterController, _categoryFilterController, safeWidth),
            ],
          ),
        ),
      )),
    );
  }
}

Widget _buildFilterCourse(TextEditingController _levelFilterController,
    TextEditingController _categoryFilterController, double safeWidth) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          child: CustomTextField.common(
            onChanged: (value) {},
            textEditingController: _levelFilterController,
            hintText: "Chọn cấp độ",
            textInputType: TextInputType.text,
            fillColor: BaseColor.lightGrey,
            editIconPath: "assets/icons/common/icon_arrow_down.png",
            edit: () {},
          ),
        ),
        const SizedBox(width: 12.0),
        Flexible(
          child: CustomTextField.common(
            onChanged: (value) {},
            textEditingController: _categoryFilterController,
            textInputType: TextInputType.text,
            hintText: "Chọn danh mục",
            fillColor: BaseColor.lightGrey,
            editIconPath: "assets/icons/common/icon_arrow_down.png",
            edit: () {},
          ),
        ),
      ]),
      const SizedBox(height: 12.0),
      SizedBox(
        width: safeWidth * 0.65,
        child: CustomTextField.common(
          onChanged: (value) {},
          textEditingController: _levelFilterController,
          hintText: "Sắp xếp theo độ khó",
          textInputType: TextInputType.text,
          fillColor: BaseColor.lightGrey,
          editIconPath: "assets/icons/common/icon_arrow_down.png",
          edit: () {},
        ),
      ),
    ],
  );
}
