import 'package:flutter/material.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Doctor home', backButton: false, signOutButton: true,),
      body: Container(color: Colors.red),
    );
  }
}