import 'package:flutter/material.dart';
import 'package:smart_ambulance/screens/authenticate/login_page.dart';
import 'package:smart_ambulance/screens/authenticate/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void changeScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: changeScreen);
    } else {
      return RegisterPage(showLoginPage: changeScreen);
    }
  }
}