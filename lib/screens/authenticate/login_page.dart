import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/screens/authenticate/forgot_password_page.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                
                const Icon(
                  Icons.local_hospital_rounded,
                  size: 100,
                  color: Colors.red,
                ),
                const SizedBox(height: 50),
          
                Text(
                  AppLocalizations.of(context)!.app_title,
                  style: SmartAmbulanceTextStyles.appTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SmartAmbulanceSizes.bigSizedBox),
          
                Text(
                  AppLocalizations.of(context)!.login_welcome,
                  style: SmartAmbulanceTextStyles.appTitleTextStyle,
                ),

                // Email textfield
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.login_email)
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),

                // Password textfield
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.login_password)
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
          
                SmartAmbulanceButton(text: AppLocalizations.of(context)!.login_button, fontSize: SmartAmbulanceSizes.bigButtonFontSize, onPressed: (() async {
                  await login();
                }),),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),

                Text(
                  error,
                  style: SmartAmbulanceTextStyles.errorTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
          
                // Forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          error = '';
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage(auth: _auth);
                            }
                          )
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login_forgot_password,
                        style: SmartAmbulanceTextStyles.pressableTextStyle
                      ),
                    )
                  ],
                ),
                const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),

                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.login_no_account,
                      style: SmartAmbulanceTextStyles.pressableAccompaniedTextStyle
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        AppLocalizations.of(context)!.login_register,
                        style: SmartAmbulanceTextStyles.pressableTextStyle
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {

    try {

      await _auth.signIn(_emailController.text.trim(), _passwordController.text.trim());

    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-email":
          setState(() => error = AppLocalizations.of(context)!.login_error_invalid_email);
          break;
        case "user-disabled":
          setState(() => error = AppLocalizations.of(context)!.login_error_used_disabled);
          break;
        case "user-not-found":
          setState(() => error = AppLocalizations.of(context)!.login_error_user_not_found);
          break;
        case "wrong-password":
          setState(() => error = AppLocalizations.of(context)!.login_error_wrong_password);
          break;
        default:
          setState(() => error = AppLocalizations.of(context)!.login_error);
          break;
      }
    }
  }
}