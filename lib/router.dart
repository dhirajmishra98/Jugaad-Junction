import 'package:flutter/material.dart';
import 'package:jugaad_junction/features/account/screens/order_details_screen.dart';
import 'package:jugaad_junction/features/address/screens/address_screen.dart';
import 'package:jugaad_junction/features/home/screens/product_detail_screen.dart';
import 'package:jugaad_junction/features/admin/screens/admin_screen.dart';
import 'package:jugaad_junction/features/admin/widgets/admin_bottom_nav_bar.dart';
import 'package:jugaad_junction/features/home/screens/home_screen.dart';
import 'package:jugaad_junction/features/home/screens/product_category_screen.dart';
import 'package:jugaad_junction/features/home/widgets/user_bottom_nav_bar.dart';
import 'package:jugaad_junction/features/search/screens/search_screen.dart';
import 'package:jugaad_junction/initials/screens/welcome_screen.dart';
import 'package:jugaad_junction/models/order.dart';

import 'features/auth/screens/auth_screen.dart';
import 'models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      );

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

    case ProductCategoryScreen.routeName:
      String category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => ProductCategoryScreen(category: category),
      );

    case SearchScreen.routeName:
      String searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => SearchScreen(searchQuery: searchQuery),
      );

    case ProductDetailScreen.routeName:
      Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      );

    case AddressScreen.routeName:
      String totalSum = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => AddressScreen(totalsum: totalSum),
      );

    case OrderDetailsScreen.routeName:
      Order order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(
          order: order,
        ),
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
