import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/global_state/navigation_index.dart';
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
    final authUser = Provider.of<AuthProvider>(context).userLoggedIn;
    final lang = Provider.of<AppProvider>(context).language;
    List<String> titles = [
      lang.home,
      lang.course,
      lang.upcoming,
      lang.tutors,
      lang.setting
    ];

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
                          child: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: CachedNetworkImage(
                                imageUrl: authUser.avatar,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          )),
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
