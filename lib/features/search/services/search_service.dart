// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/error_handling.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../models/product.dart';

class SearchService {
  Future<List<Product>> fetchSearchedProducts({
    required String searchQuery,
    required BuildContext context,
  }) async {
    List<Product> products = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
          Uri.parse('$uriFromGlobalVar/api/products/search/$searchQuery'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              products.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, "fetch unsucessfull $e");
    }
    return products;
  }
}
