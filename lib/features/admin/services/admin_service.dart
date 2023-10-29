// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/widgets/error_handling.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/common/utils.dart';
import 'package:jugaad_junction/models/order.dart';
import 'package:jugaad_junction/models/product.dart';
import 'package:jugaad_junction/models/sales.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../initials/screens/welcome_screen.dart';

class AdminService {
  //Add product
  void sellProduct({
    required BuildContext context,
    required String productName,
    required String productDescription,
    required double productPrice,
    required double productQuantity,
    required String productCategory,
    required List<File> productImages,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      dynamic cloudinary = CloudinaryPublic(
        dotenv.env['cloudName']!,
        dotenv.env['uploadPreset']!,
        cache: true,
      );
      List<String> productImageUrls = [];

      for (int i = 0; i < productImages.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            productImages[i].path,
            folder: productName.trim(),
            resourceType: CloudinaryResourceType.Image,
          ),
        );

        productImageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: productName,
        description: productDescription,
        category: productCategory,
        price: productPrice,
        quantity: productQuantity,
        images: productImageUrls,
      );

      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product Added Successfully!");
          Navigator.pop(context);
        },
      );
    } on CloudinaryException catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all product
  Future<List<Product>> getProducts(BuildContext context) async {
    List<Product> products = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('$uriFromGlobalVar/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(jsonDecode(response.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return products;
  }

  //Remove a product
  void removeProduct(
      BuildContext context, Product product, VoidCallback onSuccess) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/admin/remove-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Get all orders
  Future<List<Order>> getOrders(BuildContext context) async {
    List<Order> orders = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('$uriFromGlobalVar/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orders.add(
              Order.fromJson(
                jsonEncode(jsonDecode(response.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orders;
  }

  //Change order status
  void chageOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uriFromGlobalVar/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//Get Analytics for admin
  Future<Map<String, dynamic>> getAnalytics(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalEarnings = 0.0;
    try {
      http.Response response = await http.get(
        Uri.parse('$uriFromGlobalVar/admin/analytics'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          var res = jsonDecode(response.body);
          totalEarnings = res['totalEarnings'];
          sales = [
            Sales('Mobile', res['mobilesEarning'].toDouble()),
            Sales('Appliances', res['appliancesEarning'].toDouble()),
            Sales('Books', res['booksEarning'].toDouble()),
            Sales('Essentials', res['essentailsEarning'].toDouble()),
            Sales('Fashion', res['fashionEarnings'].toDouble()),
            Sales('Furniture', res['furnitureEarnings'].toDouble()),
            Sales('Headphones', res['headphonesEarnings'].toDouble()),
            Sales('Sports', res['sportsEarnings'].toDouble()),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarnings,
    };
  }

//Logout Admin
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
