import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/providers/user_provider.dart';
import 'package:smart_ambulance/screens/authenticate/auth_page.dart';
import 'package:smart_ambulance/screens/home/home.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
        ],
        child: const HomePage(),
      );
    }
  }
}