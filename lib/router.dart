import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/admin/screens/admin_screen.dart';
import 'package:jugaad_junction/features/admin/widgets/admin_bottom_nav_bar.dart';
import 'package:jugaad_junction/features/home/screens/home_screen.dart';
import 'package:jugaad_junction/features/home/widgets/user_bottom_nav_bar.dart';

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

    case UserBottomNavBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const UserBottomNavBar(),
      );

    case AdminScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AdminScreen(),
      );

    case AdminBottomNavBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const AdminBottomNavBar(),
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
