import 'package:flutter/material.dart';

String uriFromGlobalVar = 'http://192.168.34.234:3000'; //Wireless LAN adapter Wi-Fi: ipv4 address from laptop machine

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 32, 29, 201),
      Color.fromARGB(255, 97, 98, 215),
    ],
    stops: [0.5, 1.0],
  );

  static const Color secondaryColor = Color.fromRGBO(0, 115, 255, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 0, 62, 143);
  static const unselectedNavBarColor = Colors.black87;
}
