import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/features/account/screens/account_screen.dart';
import 'package:jugaad_junction/features/cart/screens/cart_screen.dart';
import 'package:jugaad_junction/features/home/screens/home_screen.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserBottomNavBar extends StatefulWidget {
  static const String routeName = '/user-wrapping-screen';
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<UserBottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartSize = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: GlobalVariables.secondaryColor,
        backgroundColor: Colors.transparent,
        height: 60,
        color: GlobalVariables.secondaryColor,
        key: _bottomNavigationKey,
        items:  <Widget>[
          const Icon(Icons.home_outlined, size: 28),
          const Icon(Icons.person_outlined, size: 28),
          Badge(
            label: Text(cartSize.toString()),
            textColor: Colors.black,
            backgroundColor: Colors.white,
            child:const Icon(Icons.shopping_cart_outlined, size: 28),
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page],
    );
  }
}
