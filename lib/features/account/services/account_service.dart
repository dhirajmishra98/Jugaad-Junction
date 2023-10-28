// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/common/widgets/error_handling.dart';
import 'package:jugaad_junction/initials/screens/welcome_screen.dart';
import 'package:jugaad_junction/models/order.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<List<Order>> fetchOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orders = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uriFromGlobalVar/api/orders/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              for (int i = 0; i < jsonDecode(response.body).length; i++) {
                orders.add(
                  Order.fromJson(
                    jsonEncode(
                      jsonDecode(response.body)[i],
                    ),
                  ),
                );
              }
            });
      } else {
        showSnackBar(context, jsonDecode(response.body)['error']);
      }
    } catch (e) {
      showSnackBar(context, "Order fetch failed $e");
    }

    return orders;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        WelcomeScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
