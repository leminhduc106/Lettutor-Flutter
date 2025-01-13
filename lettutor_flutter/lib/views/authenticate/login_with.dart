import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/user_model/tokens_model.dart';
import 'package:lettutor_flutter/models/user_model/user_model.dart';
import 'package:lettutor_flutter/services/auth_service.dart';
import 'package:lettutor_flutter/utils/base_style.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginWith extends StatefulWidget {
  const LoginWith({Key? key, required this.callback}) : super(key: key);
  final Function(User, Tokens, AuthProvider) callback;

  @override
  _LoginWithState createState() => _LoginWithState();
}

class _LoginWithState extends State<LoginWith> {
  late GoogleSignIn _googleSignIn;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    void handleSignInGoogle() async {
      try {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final String? accessToken = googleAuth?.accessToken;

        if (accessToken != null) {
          try {
            await AuthService.loginWithGoogle(
                accessToken, authProvider, widget.callback);
          } catch (e) {
            showTopSnackBar(Overlay.of(context),
                CustomSnackBar.error(message: "Login failed! ${e.toString()}"),
                animationDuration: const Duration(milliseconds: 1000),
                displayDuration: const Duration(microseconds: 4000));
          }
        }
      } catch (e) {
        //print(e);
      }
    }

    _googleSignIn = GoogleSignIn();
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
          onTap: () {
            // handleSingInFacebook();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: BaseColor.blue, width: 0.5),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]),
            child: SizedBox(
              height: 24,
              child: Image.asset(
                "assets/icons/social/icon_facebook.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          )),
      const SizedBox(width: 12),
      GestureDetector(
          onTap: () {
            handleSignInGoogle();
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: BaseColor.blue, width: 0.5),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]),
            child: SizedBox(
              height: 24,
              child: Image.asset(
                "assets/icons/social/icon_google.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          )),
      const SizedBox(width: 12),
      GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: BaseColor.blue, width: 0.5),
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff003399).withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]),
            child: SizedBox(
              height: 24,
              child: Image.asset(
                "assets/icons/social/icon_mobile.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          )),
    ]);
  }
}
