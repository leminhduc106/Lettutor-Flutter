import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor_flutter/provider/navigation_index.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/setting_btn.dart';
import 'package:lettutor_flutter/widgets/avatar_circle/avatar_circle.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final naviationIndex = Provider.of<NavigationIndex>(context);
    final uploadImage = Provider.of<UserProvider>(context).uploadImage;

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
                      child: uploadImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Image.file(
                                uploadImage,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const AvatarCircle(
                              width: 70,
                              height: 70,
                              source: "assets/images/profile_2.jpeg"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "Le Minh Duc",
                          style: BaseTextStyle.heading2(fontSize: 16),
                        ),
                      ),
                      Text(
                        "leminhduc1062001@gmail.com",
                        style: BaseTextStyle.body2(
                            fontSize: 13, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: const <Widget>[
                SettingButton(
                  icon: "assets/svg/ic_list.svg",
                  title: "Booking History",
                  routeName: routes.bookingHistoryPage,
                ),
                SettingButton(
                  icon: "assets/svg/ic_history.svg",
                  title: "Session History",
                  routeName: routes.sessionHistoryPage,
                ),
                SettingButton(
                  icon: "assets/svg/ic_setting2.svg",
                  title: "Advanced Settings",
                  routeName: routes.advancedSettingPage,
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: const [
                    SettingButton(
                      icon: "assets/svg/ic_network.svg",
                      title: "Our Website",
                      routeName: routes.loginPage,
                    ),
                    SettingButton(
                      icon: "assets/svg/ic_facebook2.svg",
                      title: "Facebook",
                      routeName: routes.loginPage,
                    ),
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 40),
                child: CustomButton.common(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        routes.loginPage,
                        (Route<dynamic> route) => false,
                      );
                      naviationIndex.index = 0;
                    },
                    content: "Logout"))
          ],
        ),
      ),
    );
  }
}
