import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/services/user_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/views/setting_page/change_password/input_password.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChagePasswordPageState createState() => _ChagePasswordPageState();
}

class _ChagePasswordPageState extends State<ChangePasswordPage> {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final lang = Provider.of<AppProvider>(context).language;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(lang.changePassword,
            style: BaseTextStyle.heading2(
                fontSize: 20, color: BaseColor.secondaryBlue)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InputPassword(
                  controller: passwordController, title: lang.currentPassword),
              InputPassword(
                  controller: newPasswordController, title: lang.newPassword),
              InputPassword(
                  controller: confirmPasswordController,
                  title: lang.confirmNewPassword),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff007CFF)),
                  onPressed: () async {
                    if (passwordController.text.length < 6 ||
                        newPasswordController.text.length < 6 ||
                        confirmPasswordController.text.length < 6) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(message: lang.passwordAtLeast),
                        animationDuration: const Duration(milliseconds: 1000),
                        displayDuration: const Duration(microseconds: 4000),
                      );
                    } else if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(message: lang.errPasswordMismatch),
                        animationDuration: const Duration(milliseconds: 1000),
                        displayDuration: const Duration(microseconds: 4000),
                      );
                    } else {
                      try {
                        final res = await UserService.changePassword(
                            authProvider.tokens!.access.token,
                            passwordController.text,
                            newPasswordController.text);
                        if (res) {
                          // ignore: use_build_context_synchronously
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.success(
                              message: lang.changePasswordSuccess,
                              backgroundColor: Colors.green,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 1000),
                            displayDuration: const Duration(microseconds: 4000),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(message: e.toString()),
                          animationDuration: const Duration(milliseconds: 1000),
                          displayDuration: const Duration(microseconds: 4000),
                        );
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SvgPicture.asset(
                            "assets/svg/ic_password2.svg",
                            color: Colors.white,
                            width: 20,
                          ),
                        ),
                        Text(lang.changePassword,
                            style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
