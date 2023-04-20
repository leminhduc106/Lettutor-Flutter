import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/global_state/navigation_index.dart';
import 'package:lettutor_flutter/models/tutor_model/tutor_model.dart';
import 'package:lettutor_flutter/services/tutor_service.dart';
import 'package:lettutor_flutter/services/user_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/home/components/banner.dart';
import 'package:lettutor_flutter/views/home/components/card_tutor.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tutor> _tutors = [];
  bool _isLoading = true;

  void fetchRecommendTutors(String token, AppProvider appProvider) async {
    final allTopics = await UserService.fetchAllLearningTopic(token);
    final allTestPreparation = await UserService.fetchAllTestPreparation(token);
    appProvider.load(allTopics, allTestPreparation);
    final result = await TutorService.getListTutorWithPagination(1, 9, token);
    final List<Tutor> listTutors = [];
    print("Result: ${result[2].name}");

    for (int i = 0; i < result.length; i++) {
      final tutorDetail = await TutorService.getTutor(result[i].userId, token);
      listTutors.add(tutorDetail);
    }

    if (mounted) {
      setState(() {
        _tutors = listTutors;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationIndex = Provider.of<NavigationIndex>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final lang = appProvider.language;

    if (_isLoading && authProvider.tokens != null) {
      fetchRecommendTutors(
          authProvider.tokens?.access.token as String, appProvider);
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        lang.recommendTutor,
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
                          Text(
                            lang.seeAll,
                            style: const TextStyle(color: Colors.blue),
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
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            CardTutor(tutor: _tutors[index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 12,
                        ),
                        itemCount: _tutors.length,
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
