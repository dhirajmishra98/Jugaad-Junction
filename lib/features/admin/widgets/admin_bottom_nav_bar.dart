import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jugaad_junction/common/global_variables.dart';
import 'package:jugaad_junction/features/admin/screens/admin_screen.dart';
import 'package:jugaad_junction/features/admin/screens/analytics_screen.dart';
import 'package:jugaad_junction/features/admin/screens/orders_screen.dart';

class AdminBottomNavBar extends StatefulWidget {
  static const String routeName = '/admin-wrapping-screen';
  const AdminBottomNavBar({super.key});

  @override
  State<AdminBottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<AdminBottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> pages = [
    const AdminScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: GlobalVariables.secondaryColor,
        backgroundColor: Colors.transparent,
        height: 60,
        color: GlobalVariables.secondaryColor,
        key: _bottomNavigationKey,
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 28),
          Icon(Icons.analytics_outlined, size: 28),
          Icon(Icons.all_inbox_outlined, size: 28),
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
