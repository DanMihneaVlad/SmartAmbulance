import 'package:flutter/material.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';

class ParamedicHomePage extends StatefulWidget {
  const ParamedicHomePage({super.key});

  @override
  State<ParamedicHomePage> createState() => _ParamedicHomePageState();
}

class _ParamedicHomePageState extends State<ParamedicHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Paramedic home', backButton: false, signOutButton: true,),
      body: Container(color: Colors.blue),
    );
  }
}