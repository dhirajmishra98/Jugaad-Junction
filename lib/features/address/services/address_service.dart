// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:jugaad_junction/common/widgets/error_handling.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class AddressService {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userAddress': address,
        }),
      );

      if(response.statusCode == 200) {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(response.body)['address'],
            );
            userProvider.setUserFromModel(user);
          });
      }else{
        showSnackBar(context, jsonDecode(response.body)['error']);
      }
    } catch (e) {
      showSnackBar(context, "User Address Save Failed $e");
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'totalPrice': totalSum,
          'address': address,
        }),
      );

      if (response.statusCode == 200) {
        httpErrorHandle(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, "Your order has been placed");
              User user = userProvider.user.copyWith(
                cart: [],
              );
              userProvider.setUserFromModel(user);
            });
      } else {
        showSnackBar(context, jsonDecode(response.body)['error']);
      }
    } catch (e) {
      //Handling other network errors
      showSnackBar(context, "Place Order Failed $e");
    }
  }
}
