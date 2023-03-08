import 'dart:math';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  final _findTutorController = TextEditingController();
  final _tutorNationController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  List<String> _filterItems = [
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
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            _buildCourseInfor(size, safeWidth),
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
                  Text(
                    "Gia sư được đề xuất ",
                    style: BaseTextStyle.heading4(fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  _buildTutorInfor(safeWidth, _tutorItems),
                  const SizedBox(height: 16),
                  _buildTutorInfor(safeWidth, _tutorItems),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

Widget _buildTutorInfor(double safeWidth, List<String> tutorItems) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage("assets/images/teacher.png"),
              ),
            ),
            Positioned(
              //top right
              top: 5,
              right: 5,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.blue,
                    size: 32,
                  )),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Keegan",
              style: BaseTextStyle.body3(fontSize: 18),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10.0,
              runSpacing: 14.0,
              children: tutorItems.map<Widget>((item) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 212, 212, 212),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Text(item, style: BaseTextStyle.body2(fontSize: 14)),
                );
              }).toList(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Text(
            'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around',
            style: BaseTextStyle.body2(fontSize: 14),
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 10),
          width: safeWidth * 0.4,
          child: CustomButton.whiteBtnWithIcon(
              onTap: () {},
              content: "Đặt lịch",
              iconPath: "assets/icons/common/icon_calendar_blue.png"),
        )
      ],
    ),
  );
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
              onTap: () {},
              content: "Vào lớp học",
              iconPath: "assets/icons/social/icon_youtube.png"),
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
