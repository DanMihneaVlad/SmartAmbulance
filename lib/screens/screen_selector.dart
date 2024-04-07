import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      return Container(color: Colors.blue);
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