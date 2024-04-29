import 'package:flutter/material.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.backButton, this.signOutButton = false});

  final String title;
  final bool backButton;
  final bool signOutButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      leading: _getBackButton(context),
      actions: <Widget>[
        _getSignOutButton(context)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget _getBackButton(BuildContext context) {
    if (backButton) {
      return IconButton(
        onPressed: () => Navigator.pop(context), 
        icon: const Icon(Icons.keyboard_arrow_left)
      );
    } else {
      return Container();
    }
  }

  Widget _getSignOutButton(BuildContext context) {
    if (signOutButton) {
      
      final AuthService auth = AuthService();

      return IconButton(
        onPressed: () async {
          await auth.signOut();
        }, 
        tooltip: AppLocalizations.of(context)!.appbar_sign_out,
        icon: const Icon(Icons.logout_outlined)
      );
    } else {
      return Container();
    }
  }
}