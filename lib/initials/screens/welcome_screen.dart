import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../features/auth/screens/auth_screen.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome-screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Image.asset(
                  'assets/images/ecommerce-logo.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Sign in to your account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Lottie.asset(
                  'assets/animations/welcome.json',
                  animate: true,
                  repeat: true,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                CustomButton(
                  text: 'Already a customer? Sign in',
                  onTap: () => Navigator.pushNamed(
                    context,
                    AuthScreen.routeName,
                    arguments: {"signInRoute": true},
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'New to Jugaad-Junction? Sign up',
                  onTap: () => Navigator.pushNamed(
                    context,
                    AuthScreen.routeName,
                    arguments: {"signInRoute": false},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
