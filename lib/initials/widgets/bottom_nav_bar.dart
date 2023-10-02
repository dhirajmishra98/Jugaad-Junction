import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jugaad_junction/constants/global_variables.dart';
import 'package:jugaad_junction/features/account/screens/account_screen.dart';
import 'package:jugaad_junction/features/home/screens/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/main-wrapping-screen';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const Center(
      child: Text("cart screen"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: GlobalVariables.secondaryColor,
        backgroundColor: GlobalVariables.backgroundColor,
        height: 60,
        color: GlobalVariables.secondaryColor,
        key: _bottomNavigationKey,
        items: const <Widget>[
          Icon(Icons.home_outlined, size: 28),
          Icon(Icons.person_outlined, size: 28),
          Badge(
            label: Text("2"),
            textColor: Colors.black,
            backgroundColor: Colors.white,
            child: Icon(Icons.shopping_cart_outlined, size: 28),
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

// Container(
//         color: GlobalVariables.backgroundColor,
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               Text(_page.toString(), textScaleFactor: 10.0),
//               ElevatedButton(
//                 child: Text('Go To Page of index 1'),
//                 onPressed: () {
//                   //Page change using state does the same as clicking index 1 navigation button
//                   final CurvedNavigationBarState? navBarState =
//                       _bottomNavigationKey.currentState;
//                   navBarState?.setPage(1);
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
