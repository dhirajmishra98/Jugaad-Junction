
import 'package:flutter/material.dart';

import '../../../common/global_variables.dart';
import '../../../initials/widgets/custom_button.dart';
import '../../../initials/widgets/custom_textfield.dart';
import '../services/auth_service.dart';

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
  late Auth _auth;
  // Auth _auth = Auth.signUp;
  final _signUpForm = GlobalKey<FormState>();
  final _signInForm = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void signUpUser() {
    _authService.signUpUser(
        context: context,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text);
  }

  void signInUser() {
    _authService.signInUser(
      context: context,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    _auth = args['signInRoute'] == false ? Auth.signUp : Auth.signIn;
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/ecommerce-logo.png',
                    height: 50,
                    width: 150,
                  ),
                ),
                const Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    color: _auth == Auth.signUp
                        ? GlobalVariables.backgroundColor
                        : null,
                  ),
                  child: ListTile(
                    title: const RadioTitle(
                      primaryText: 'Create Account. ',
                      secondaryText: 'New to Jugaad-Junction?',
                    ),
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signUp,
                        groupValue: _auth,
                        onChanged: (Auth? value) {
                          setState(() {
                            args['signInRoute'] = !args['signInRoute'];
                            // _auth = value!;
                          });
                        }),
                    minLeadingWidth: 1,
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: GlobalVariables.backgroundColor,
                    ),
                    child: Form(
                      key: _signUpForm,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            labelText: 'First and last name',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: _emailController,
                            labelText: 'email',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: 'password',
                            isPasswordField: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                                textAlign: TextAlign.start,
                                text: const TextSpan(
                                    text: '* ',
                                    style: TextStyle(color: Colors.red),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Password must be at least 6 characters.',
                                          style: TextStyle(color: Colors.black))
                                    ])),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpForm.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    color: _auth == Auth.signIn
                        ? GlobalVariables.backgroundColor
                        : null,
                  ),
                  child: ListTile(
                    title: const RadioTitle(
                      primaryText: 'Sign in. ',
                      secondaryText: 'Already a customer?',
                    ),
                    leading: Radio(
                        activeColor: GlobalVariables.secondaryColor,
                        value: Auth.signIn,
                        groupValue: _auth,
                        onChanged: (Auth? value) {
                          setState(() {
                            args['signInRoute'] = !args['signInRoute'];
                            // _auth = value!;
                          });
                        }),
                    minLeadingWidth: 1,
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 15, left: 15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: GlobalVariables.backgroundColor,
                    ),
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
                            isPasswordField: true,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomButton(
                            text: 'Sign In',
                            onTap: () {
                              if (_signInForm.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          ),
                        ],
                      ),
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

class RadioTitle extends StatelessWidget {
  const RadioTitle({
    required this.primaryText,
    required this.secondaryText,
    super.key,
  });

  final String primaryText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: primaryText,
        style:
            const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: secondaryText,
              style: const TextStyle(fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}
