
import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/admin/screens/admin_screen.dart';
import 'package:jugaad_junction/features/home/screens/home_screen.dart';
import 'package:jugaad_junction/initials/widgets/bottom_nav_bar.dart';

import 'features/auth/screens/auth_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case BottomNavBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomNavBar(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        builder: (context) =>const AdminScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error Occurred'),
          ),
        ),
      );
  }
}
