import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopit/constants/error_handling.dart';
import 'package:shopit/constants/global_variables.dart';
import 'package:shopit/constants/utils.dart';
import 'package:shopit/features/auth/screens/auth.screen.dart';
import 'package:shopit/models/order.dart';
import 'package:shopit/providers/user.provider.dart';

class AccountService {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    List<Order> orderList = [];

    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString('x-auth-token', '');

      bool mounted = true;
      // ignore: dead_code
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
