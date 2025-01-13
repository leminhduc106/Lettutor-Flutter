import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/global_state/navigation_index.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/setting_btn.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final naviationIndex = Provider.of<NavigationIndex>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userAuth = authProvider.userLoggedIn;
    final lang = Provider.of<AppProvider>(context).language;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 70,
                    width: 70,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: CachedNetworkImage(
                            imageUrl: userAuth.avatar,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          userAuth.name,
                          style: BaseTextStyle.heading2(fontSize: 16),
                        ),
                      ),
                      Text(
                        userAuth.email,
                        style: BaseTextStyle.body2(
                            fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SettingButton(
                  icon: "assets/svg/ic_history.svg",
                  title: lang.sessionHistory,
                  routeName: routes.sessionHistoryPage,
                ),
                SettingButton(
                  icon: "assets/svg/ic_setting2.svg",
                  title: lang.advancedSetting,
                  routeName: routes.advancedSettingPage,
                ),
                SettingButton(
                  icon: "assets/svg/ic_tutor.svg",
                  title: lang.becomeTutor,
                  routeName: routes.becomeTeacher,
                ),
                userAuth.roles != null &&
                        userAuth.roles!.contains("CHANGE_PASSWORD")
                    ? SettingButton(
                        icon: "assets/svg/ic_password2.svg",
                        title: lang.changePassword,
                        routeName: routes.changePasswordPage,
                      )
                    : Container(),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          launch("https://lettutor.com/");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1000))),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/ic_network.svg",
                                    width: 25,
                                    color: Colors.grey[700],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      lang.ourWebsite,
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                "assets/svg/ic_next.svg",
                                color: Colors.grey[700],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          launch("fb://page/107781621638450");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1000))),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/ic_facebook2.svg",
                                    width: 25,
                                    color: Colors.grey[700],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Facebook",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13),
                                    ),
                                  )
                                ],
                              ),
                              SvgPicture.asset(
                                "assets/svg/ic_next.svg",
                                color: Colors.grey[700],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 40, bottom: 40),
                child: CustomButton.common(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("refresh_token");
                    authProvider.tokens = null;
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      routes.loginPage,
                      (Route<dynamic> route) => false,
                    );
                    naviationIndex.index = 0;
                  },
                  content: lang.logout,
                ))
          ],
        ),
      ),
    );
  }
}
