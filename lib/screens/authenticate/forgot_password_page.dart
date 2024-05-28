import 'package:flutter/material.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/screens/authenticate/forgot_password_page.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:smart_ambulance/widgets/custom_alert_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.auth});

  final AuthService auth;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title:"Forgot password", backButton: true),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "In order to reset your password please enter the email in the text field below.\n After you successfully entered a valid email address, you will receive an email containing the password reset link",
                  textAlign: TextAlign.center,
                  style: SmartAmbulanceTextStyles.userTileTextStyle,
                ),
                const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox,),

                // Email textfield
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(SmartAmbulanceSizes.borderRadius),
                    ),
                    hintText: AppLocalizations.of(context)!.login_email,
                    fillColor: Colors.grey[250],
                    filled: true
                  ),
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),

                SmartAmbulanceButton(text: "Reset password", fontSize: SmartAmbulanceSizes.bigButtonFontSize, onPressed: (() async {
                  await resetPassword();
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    try {
      await widget.auth.resetPassword(_emailController.text.trim());

      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
          CustomAlertDialog(
            title: "Password reset link sent! Check your email"));

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "unknown":
          showDialogError("Email is empty");
          break;
        case "invalid-email":
          showDialogError("Email is invalid");
          break;
        case "user-not-found":
          showDialogError("User not found");
          break;
        default:
          showDialogError("Error");
      }
    }
  }

  void showDialogError(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(content: Text(message));
      }
    );
  }
}