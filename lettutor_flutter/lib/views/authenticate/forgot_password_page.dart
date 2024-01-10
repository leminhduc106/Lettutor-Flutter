import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/models/language_model/language.dart';
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
  final _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();

    super.dispose();
  }

  void _resetPassword(Language language) async {
    if (_emailController.text.isEmpty) {
      showTopSnackBar(
          context, CustomSnackBar.error(message: language.emptyField),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 4000));
      return;
    }
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      try {
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
        }
      } catch (e) {
        showTopSnackBar(
            context,
            CustomSnackBar.error(
                message: "Reset password failed! ${e.toString()}"),
            showOutAnimationDuration: const Duration(milliseconds: 1000),
            displayDuration: const Duration(microseconds: 4000));
      }
    } else {
      showTopSnackBar(
          context, CustomSnackBar.error(message: language.invalidEmail),
          showOutAnimationDuration: const Duration(milliseconds: 1000),
          displayDuration: const Duration(microseconds: 4000));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    final appProvider = Provider.of<AppProvider>(context);
    final language = appProvider.language;

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
                                              text: " Email ",
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
                                    textEditingController: _emailController,
                                    hintText: language.enterEmail,
                                    textInputType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  CustomButton.common(
                                      onTap: () {
                                        _resetPassword(language);
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
