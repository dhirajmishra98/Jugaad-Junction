// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/common/widgets/error_handling.dart';
import 'package:jugaad_junction/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/api/product/rating'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'productId': product.id,
          'rating': rating,
        }),
      );

      httpErrorHandle(response: response, context: context, onSuccess: () {});
    } catch (e) {
      showSnackBar(context, "Failed to Rate, $e");
    }
  }
}
