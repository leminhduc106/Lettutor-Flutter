import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/services/auth_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:lettutor_flutter/widgets/custom_appbar/custom_appbar.dart';
import 'package:lettutor_flutter/widgets/custom_button/custom_button.dart';
import 'package:lettutor_flutter/widgets/custom_textfield/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    final appProvider = Provider.of<AppProvider>(context);
    final language = appProvider.language;

    void _resetPassword() async {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailController.text)) {
        showTopSnackBar(
            context, CustomSnackBar.error(message: language.invalidEmail),
            showOutAnimationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000));
      } else if (_emailController.text.isNotEmpty) {
        final bool res =
            await AuthService.forgotPassword(_emailController.text);
        if (res) {
          // ignore: use_build_context_synchronously
          showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: language.forgotPasswordSuccess,
                backgroundColor: Colors.green,
              ),
              showOutAnimationDuration: const Duration(milliseconds: 1000),
              displayDuration: const Duration(microseconds: 4000));
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          showTopSnackBar(context,
              CustomSnackBar.error(message: language.forgotPasswordFail),
              showOutAnimationDuration: const Duration(milliseconds: 1000),
              displayDuration: const Duration(microseconds: 4000));
        }
      }
    }

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
                      color: Colors.white,
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
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Container(
                  width: safeWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: heightSafeArea,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    language.resetPassword,
                                    style: BaseTextStyle.heading4(
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 18),
                                  RichText(
                                    text: TextSpan(
                                        style: BaseTextStyle.body2(
                                            color: Colors.black),
                                        children: [
                                          TextSpan(text: language.pleaseEnter),
                                          TextSpan(
                                              text: "Email ",
                                              style: BaseTextStyle.subtitle2(
                                                  color: Colors.black)),
                                          TextSpan(
                                              text: language.pleaseEnterEmail),
                                        ]),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField.common(
                                    onChanged: (value) {},
                                    labelText: "Email",
                                    hintText: language.enterEmail,
                                    textInputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  CustomButton.common(
                                      onTap: () {
                                        _resetPassword();
                                      },
                                      content: language.confirmReset),
                                  SizedBox(height: size.height * 0.02),
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 15,
                                        color: BaseColor.blue,
                                      ),
                                      label: Text(language.gobackLogin,
                                          style: BaseTextStyle.body2(
                                              color: BaseColor.blue)))
                                ]))
                      ]))),
        ),
      ),
    );
  }
}
