// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jugaad_junction/features/home/widgets/user_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/error_handling.dart';
import '../../../common/global_variables.dart';
import '../../../common/utils.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AuthService {
  //sign up service
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(
        Uri.parse("$uriFromGlobalVar/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Account created! log in with same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, "sokcet problem $e");
    }
  }

//signin service
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse("$uriFromGlobalVar/api/signin"),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            UserBottomNavBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response tokenRes = await http.post(
        Uri.parse('$uriFromGlobalVar/isValidToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uriFromGlobalVar/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  void uploadAvatar(File profilePic, BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      dynamic cloudinary = CloudinaryPublic(
        dotenv.env['_cloudName']!,
        dotenv.env['_uploadPreset']!,
        cache: true,
      );
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          profilePic.path,
          folder: "Avatars",
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      await http.post(
        Uri.parse('$uriFromGlobalVar/api/user-avatar'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'avatar': res.secureUrl,
        }),
      );

      getUserData(context);
    } catch (e) {
      showSnackBar(context, "Uploading Avatar Failed!");
    }
  }
}
