import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/screens/authenticate/auth_page.dart';

class ScreenSelector extends StatefulWidget {
  const ScreenSelector({super.key});

  @override
  State<ScreenSelector> createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    if (user == null) {
      return const AuthPage();
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Container(color: Colors.green),
          ),
        ),
      );
    }
  }
}