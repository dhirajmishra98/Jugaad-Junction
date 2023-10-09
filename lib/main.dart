import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:jugaad_junction/features/admin/widgets/admin_bottom_nav_bar.dart';
import 'package:jugaad_junction/features/home/widgets/user_bottom_nav_bar.dart';
import 'package:jugaad_junction/initials/screens/welcome_screen.dart';
import 'package:jugaad_junction/providers/user_provider.dart';
import 'package:jugaad_junction/router.dart';

import 'common/global_variables.dart';
import 'features/auth/services/auth_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.apikeys");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jugaad Junction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'admin'
              ? const AdminBottomNavBar()
              : const UserBottomNavBar()
          : const WelcomeScreen(),
    );
  }
}
