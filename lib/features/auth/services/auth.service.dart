import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/common/widgets/bottom_bar.dart';
import 'package:shopit/constants/error_handling.dart';
import 'package:shopit/constants/utils.dart';
import 'package:shopit/providers/user.provider.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';

class AuthService {
  // Signup user
  void signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: 'address',
          type: 'type',
          token: 'token',
          cart: ['cart']);

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created! You can log in.');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Signin user
  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);

          SharedPreferences preferences = await SharedPreferences.getInstance();

          await preferences.setString(
            'x-auth-token',
            jsonDecode(res.body)['token'],
          );

          const bool mounted = true;

          // ignore: dead_code
          if (!mounted) return;
          Navigator.pushNamedAndRemoveUntil(
            context,
            // HomeScreen.routeName,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get user data
  void getUserData({required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      String? token = preferences.getString('x-auth-token');

      if (token == null) {
        preferences.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        const bool mounted = true;
        // ignore: dead_code
        if (!mounted) return;
        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
