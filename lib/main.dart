import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/other/firebase_options.dart';
import 'package:smart_ambulance/screens/screen_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const SmartAmbulance());
}

class SmartAmbulance extends StatelessWidget {
  const SmartAmbulance({super.key});

  // Application root
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(), 
      initialData: null,
      child: const MaterialApp(
        title: 'SmartAmbulance',
        home: ScreenSelector()
      )
    );
  }
}