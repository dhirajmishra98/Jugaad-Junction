import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../features/auth/screens/auth_screen.dart';
import '../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome-screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              //     child: const Text(
              //       'Search, rate and buy products\n\nView details of purchase\n\nPayment to Gpay/Applepay',
              //       softWrap: true,
              //       style: TextStyle(
              //         fontSize: 20,
              //         // fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   ),
              // ),
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
                      context, AuthScreen.routeName,
                      arguments: {"signInRoute": true})),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: 'New to Jugaad-Junction? Sign up',
                  onTap: () => Navigator.pushNamed(
                      context, AuthScreen.routeName,
                      arguments: {"signInRoute": false})),
            ],
          ),
        ),
      ),
    );
  }
}
