import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.user.email, backButton: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding),
          child: Container(color: Colors.amber,),
        )
      ),
    );
  }
}