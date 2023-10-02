// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jugaad_junction/constants/utils.dart';
import 'package:jugaad_junction/features/account/widgets/my_orders.dart';
import 'package:jugaad_junction/features/account/widgets/top_buttons.dart';
import 'package:jugaad_junction/features/auth/services/auth_service.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File? image;
  final AuthService _authService = AuthService();

  void pickImage() async {
    image = await pickImageFromGallery(context);
    if (image == null) return;
    _authService.uploadAvatar(context, File(image!.path));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Hi,\n",
                        style:
                            const TextStyle(fontSize: 30, color: Colors.black),
                        children: [
                          TextSpan(
                              text: user.name.length >= 12
                                  ? user.name.substring(0, 10)
                                  : user.name.toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ]),
                  ),
                  InkWell(
                    onTap: pickImage,
                    child: image == null
                        ? const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/upload_avatar.png',
                            ),
                            radius: 40,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 40,
                            onBackgroundImageError: (exception, stackTrace) =>
                                const AssetImage(
                              'assets/images/upload_avatar.png',
                            ),
                          ),
                  )
                ],
              ),
              const TopButton(),
              const MyOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
