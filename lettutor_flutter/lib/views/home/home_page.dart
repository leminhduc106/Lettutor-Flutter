import 'dart:math';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/provider/navigation_index.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/home/components/banner.dart';
import 'package:lettutor_flutter/views/home/components/recommend_tutor.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _findTutorController = TextEditingController();
  final _tutorNationController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final List<String> _filterItems = [
    'Tất cả',
    'Tiếng Anh cho trẻ em',
    'Tiếng Anh cho công việc',
    'Giao tiếp',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];

  @override
  Widget build(BuildContext context) {
    final navigationIndex = Provider.of<NavigationIndex>(context);

    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    return SafeArea(
      child: ListView(children: [
        Column(mainAxisSize: MainAxisSize.max, children: [
          const BannerHomePage(),
          const SizedBox(height: 16.0),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFindTutor(_findTutorController, _tutorNationController),
                const SizedBox(height: 16),
                Text(
                  "Chọn thời gian dạy kèm có lịch trống:",
                  style: BaseTextStyle.body3(fontSize: 14),
                ),
                const SizedBox(height: 8),
                _buildTimeFilter(
                    safeWidth, _startTimeController, _endTimeController),
                const SizedBox(height: 16),
                _buildFilterItem(safeWidth, _filterItems),
                const SizedBox(height: 24),
                const Divider(thickness: 1),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "Recommended Tutors",
                        style: BaseTextStyle.heading4(fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigationIndex.index = 3;
                      },
                      child: Row(
                        children: [
                          const Text(
                            "See all",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SvgPicture.asset(
                            "assets/svg/ic_next.svg",
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      RecommendTutors().tutors[index],
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 12,
                  ),
                  itemCount: RecommendTutors().tutors.length,
                ),
              ],
            ),
          )
        ]),
      ]),
    );
  }
}

Widget _buildFilterItem(double safeWidth, List<String> filterItems) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 10.0,
        runSpacing: 14.0,
        children: filterItems.map<Widget>((item) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 212, 212, 212),
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Text(item, style: BaseTextStyle.body2(fontSize: 14)),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: safeWidth * 0.52,
        child: CustomButton.whiteBackGround(
            onTap: () {}, content: "Đặt lại bộ tìm kiếm"),
      ),
    ],
  );
}

Widget _buildFindTutor(TextEditingController _findTutorController,
    TextEditingController _tutorNationController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Tìm kiếm gia sư", style: BaseTextStyle.heading4()),
      const SizedBox(height: 16.0),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
          child: CustomTextField.common(
            onChanged: (value) {},
            textEditingController: _findTutorController,
            hintText: "Nhập tên gia sư...",
            textInputType: TextInputType.name,
            fillColor: BaseColor.lightGrey,
          ),
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: CustomTextField.common(
            onChanged: (value) {},
            textEditingController: _tutorNationController,
            textInputType: TextInputType.text,
            hintText: "Chọn quốc tịch...",
            fillColor: BaseColor.lightGrey,
            editIconPath: "assets/icons/common/icon_arrow_down.png",
            edit: () {},
          ),
        ),
      ]),
    ],
  );
}

Widget _buildTimeFilter(
  double safeWidth,
  TextEditingController _startTimeController,
  TextEditingController _endTimeController,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: safeWidth * 0.54,
        child: CustomTextField.common(
          onChanged: (value) {},
          textEditingController: _startTimeController,
          textInputType: TextInputType.text,
          hintText: "Chọn một ngày...",
          fillColor: BaseColor.lightGrey,
          editIconPath: "assets/icons/common/icon_calendar.png",
          edit: () {},
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Flexible(
            child: CustomTextField.common(
              onChanged: (value) {},
              textEditingController: _endTimeController,
              textInputType: TextInputType.text,
              hintText: "Giờ bắt đầu",
              fillColor: BaseColor.lightGrey,
              editIconPath: "assets/icons/common/icon_clock.png",
              edit: () {},
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios_sharp, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: CustomTextField.common(
              onChanged: (value) {},
              textEditingController: _endTimeController,
              textInputType: TextInputType.text,
              hintText: "Giờ kết thúc",
              fillColor: BaseColor.lightGrey,
              editIconPath: "assets/icons/common/icon_clock.png",
              edit: () {},
            ),
          ),
        ],
      ),
    ],
  );
}
