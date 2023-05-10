import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/models/user_model/tokens_model.dart';
import 'package:lettutor_flutter/models/user_model/user_model.dart';

class AuthService {
  static const String url = 'https://sandbox.api.lettutor.com';
  //static Tokens? tokens;

  static User parseUser(String responseBody) {
    final parsed = json.decode(responseBody);
    return User.fromJson(parsed);
  }

  static authenticate(String refreshToken, AuthProvider authProvider,
      Function(User, Tokens, AuthProvider) callback) async {
    final response =
        await http.post(Uri.parse("$url/auth/refresh-token"), body: {
      'refreshToken': refreshToken,
      'timezone': "7",
    });
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      final tokens = Tokens.fromJson(jsonDecode["tokens"]);
      final user = User.fromJson(jsonDecode["user"]);
      await callback(user, tokens, authProvider);
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static loginByEmailAndPassword(
      String email,
      String password,
      AuthProvider authProvider,
      Function(User, Tokens, AuthProvider) callback) async {
    final response = await http.post(Uri.parse("$url/auth/login"),
        body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      final tokens = Tokens.fromJson(jsonDecode["tokens"]);
      final user = User.fromJson(jsonDecode["user"]);
      await callback(user, tokens, authProvider);
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static loginWithGoogle(String accessToken, AuthProvider authProvider,
      Function(User, Tokens, AuthProvider) callback) async {
    final response = await http.post(Uri.parse("$url/auth/google"),
        body: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      final tokens = Tokens.fromJson(jsonDecode["tokens"]);
      final user = User.fromJson(jsonDecode["user"]);
      await callback(user, tokens, authProvider);
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static loginWithFacebook(String accessToken, AuthProvider authProvider,
      Function(User, Tokens, AuthProvider) callback) async {
    final response = await http.post(Uri.parse("$url/auth/facebook"),
        body: {'access_token': accessToken});
    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      final tokens = Tokens.fromJson(jsonDecode["tokens"]);
      final user = User.fromJson(jsonDecode["user"]);
      await callback(user, tokens, authProvider);
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static registerWithEmailAndPassword(
      String email, String password, Function() callback) async {
    final response = await http.post(Uri.parse("$url/auth/register"), body: {
      'email': email,
      'password': password,
      "source": "null",
    });

    if (response.statusCode == 201) {
      await callback();
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  static Future<bool> forgotPassword(String email) async {
    final response =
        await http.post(Uri.parse("$url/user/forgotPassword"), body: {
      'email': email,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }
}
