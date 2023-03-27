import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/provider/navigation_index.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/courses_search_page/courses.dart';
import 'package:lettutor_flutter/views/home/home_page.dart';
import 'package:lettutor_flutter/views/setting_page/setting.dart';
import 'package:lettutor_flutter/views/tutors_search_page/tutors.dart';
import 'package:lettutor_flutter/views/upcoming_page/upcoming.dart';
import 'package:lettutor_flutter/widgets/menu_item/menu_item.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List<String> titles = ["Home", "Courses", "Upcoming", "Tutors", "Setting"];
  List<Widget> pages = [
    const HomePage(),
    const CoursesSearchPage(),
    const UpcomingPage(),
    const TutorsPage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    final navigationIndex = Provider.of<NavigationIndex>(context);

    final uploadImage = Provider.of<UserProvider>(context).uploadImage;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.primary),
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
          actions: navigationIndex.index == 0
              ? [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            routes.profilePage,
                          );
                        },
                        child: uploadImage != null
                            ? CircleAvatar(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Image.file(
                                    uploadImage,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/profile_2.jpeg",
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )
                ]
              : [],
        ),
        backgroundColor: Colors.white,
        body: pages[navigationIndex.index],
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.grey,
            child: Badge(
              alignment: AlignmentDirectional.bottomEnd,
              label: const Text(
                "2",
                style: TextStyle(fontSize: 11),
              ),
              child: SizedBox(
                height: 42,
                child: Image.asset(
                  "assets/icons/action/icon_message.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          onTap: (int value) {
            navigationIndex.index = value;
          },
          elevation: 20,
          currentIndex: navigationIndex.index,
          items: [
            const MenuItem(sourceIcon: "assets/svg/ic_home.svg", label: "Home")
                .generateItem(context),
            const MenuItem(
                    sourceIcon: "assets/svg/ic_course.svg", label: "Courses")
                .generateItem(context),
            const MenuItem(
                    sourceIcon: "assets/svg/ic_upcoming.svg", label: "Upcoming")
                .generateItem(context),
            const MenuItem(
                    sourceIcon: "assets/svg/ic_tutor.svg", label: "Tutors")
                .generateItem(context),
            const MenuItem(
                    sourceIcon: "assets/svg/ic_setting.svg", label: "Setting")
                .generateItem(context),
          ],
        ),
      ),
    );
  }
}
