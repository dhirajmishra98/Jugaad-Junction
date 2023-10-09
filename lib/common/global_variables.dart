import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String uriFromGlobalVar = dotenv.env[
    'hosted']!; //Wireless LAN adapter Wi-Fi: ipv4 address from laptop machine

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
  static const cardColor = 0xFFc1d5e0;

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static List<Map<String, String>> topCategories = [
    {
      'title': 'Mobiles',
      'image': 'assets/icons/mobiles.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/icons/appliance.png',
    },
    {
      'title': 'Books',
      'image': 'assets/icons/books.png',
    },
    {
      'title': 'Essentials',
      'image': 'assets/icons/essentials.png',
    },
    {
      'title': 'Fashion',
      'image': 'assets/icons/fashion.png',
    },
    {
      'title': 'Furniture',
      'image': 'assets/icons/furniture.png',
    },
    {
      'title': 'Headphones',
      'image': 'assets/icons/headphones.png',
    },
    {
      'title': 'Sports',
      'image': 'assets/icons/sports.png',
    },
  ];
}
