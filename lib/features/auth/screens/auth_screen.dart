import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

enum Auth {
  signUp,
  signIn,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final GlobalKey _signUpForm = GlobalKey<FormState>();
  final GlobalKey _signInForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
              ),
              ListTile(
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signUp,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
                tileColor: _auth == Auth.signUp
                    ? GlobalVariables.backgroundColor
                    : null,
              ),
              if (_auth == Auth.signUp)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _signUpForm,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          labelText: 'Name',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                title: const Text(
                  'Sign-In',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signIn,
                    groupValue: _auth,
                    onChanged: (Auth? value) {
                      setState(() {
                        _auth = value!;
                      });
                    }),
                tileColor: _auth == Auth.signIn
                    ? GlobalVariables.backgroundColor
                    : null,
              ),
              if (_auth == Auth.signIn)
                Container(
                  color: GlobalVariables.backgroundColor,
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _signInForm,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: 'Password',
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
