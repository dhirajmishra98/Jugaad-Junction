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

import '../../../models/user.dart';

class ProductServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'productId': product.id,
        }),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
            showSnackBar(context, "Product added to cart!");
          });
    } catch (e) {
      showSnackBar(context, "Proudct Add to Cart Failed $e");
    }
  }

  void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uriFromGlobalVar/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
            showSnackBar(context, "Product removed from cart!");
          });
    } catch (e) {
      showSnackBar(context, "Product Remove Failed $e");
    }
  }

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

  Future<Product> getDealOfDay(BuildContext context) async {
    Product product = Product(
        name: "",
        description: "",
        category: "",
        price: 0,
        quantity: 0,
        images: []);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('$uriFromGlobalVar/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            product = Product.fromJson(response.body);
          });
    } catch (e) {
      showSnackBar(context, "Deal of Day Error Loading $e");
    }
    return product;
  }
}
