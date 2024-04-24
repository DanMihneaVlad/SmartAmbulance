import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/enums/user_role_enum.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  UserRole? _role;

  RegExp regexLetters = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
  RegExp regexNumbers = RegExp(r'^(?=.*?[0-9])');

  String error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_hospital_rounded,
                    size: 100,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 50),
            
                  Text(
                    AppLocalizations.of(context)!.register_register_now,
                    style: SmartAmbulanceTextStyles.appTitleTextStyle,
                  ),
                  const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox),
            
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Email textfield
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                              return AppLocalizations.of(context)!.register_error_email;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_email),
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                        // Password textfield
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty || _passwordController.text.trim().length < 6) {
                              return AppLocalizations.of(context)!.register_error_password_length;
                            } else if (!regexLetters.hasMatch(value)) {
                              return AppLocalizations.of(context)!.register_error_password_letter_format;
                            } else if (!regexNumbers.hasMatch(value)) {
                              return AppLocalizations.of(context)!.register_error_password_number_format;
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLength: 32,
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_password),
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                        // Confirm password textfield
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (value) {
                            if (_passwordController.text.trim().isNotEmpty) {
                              if (_passwordController.text.trim() != value) {
                                return AppLocalizations.of(context)!.register_error_confirm_password;
                              }
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLength: 32,
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_confirm_password),
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                        // First name textfield
                        TextFormField(
                          controller: _firstNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 2) {
                              return AppLocalizations.of(context)!.register_error_first_name;
                            }
                            return null;
                          },
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_first_name),
                          minLines: 1,
                          maxLines: 2,
                          maxLength: 32,
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                        // Last name textfield
                        TextFormField(
                          controller: _lastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 2) {
                              return AppLocalizations.of(context)!.register_error_last_name;
                            }
                            return null;
                          },
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_last_name),
                          minLines: 1,
                          maxLines: 2,
                          maxLength: 32,
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                        // Role textfield
                        DropdownButtonFormField(
                          value: _role,
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!.register_error_role_no_value;
                            }
                            return null;
                          },
                          onChanged: (UserRole? newValue) {
                            _role = newValue!;
                          },
                          items: UserRole.values.map<DropdownMenuItem<UserRole>>((UserRole value) {
                            return DropdownMenuItem<UserRole>(value: value, child: Text(value.name));
                          }).toList(), 
                          decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.register_hint_role),
                        ),
                        const SizedBox(height: SmartAmbulanceSizes.bigSizedBox)
                      ],
                    ),
                  ),
            
                  SmartAmbulanceButton(text: AppLocalizations.of(context)!.register_button, fontSize: SmartAmbulanceSizes.bigButtonFontSize, onPressed: (() async {
                    await register();
                  }),),
                  const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                  // Register error
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding),
                    child: Text(
                      error,
                      style: SmartAmbulanceTextStyles.errorTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
            
                  // Log in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.register_already,
                        style: SmartAmbulanceTextStyles.pressableAccompaniedTextStyle
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          AppLocalizations.of(context)!.register_login,
                          style: SmartAmbulanceTextStyles.pressableTextStyle
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: SmartAmbulanceSizes.smallSizedBox)
                ],
              ),
            ),
          )
        ),
      ),
    );
  }

  Future<void> register() async {
    try {

      setState(() {
        error = '';
      });

      if (_formKey.currentState!.validate()) {
        await _auth.register(_emailController.text.trim(), _passwordController.text.trim(), _confirmPasswordController.text.trim(), _firstNameController.text.trim(), _lastNameController.text.trim(), _role!.id);
      }
    } on FirebaseAuthException catch (e) {
      switch(e.code) {
        case "invalid-email":
          setState(() => error = AppLocalizations.of(context)!.register_error_email);
          break;
        case "email-already-in-use":
          setState(() => error = AppLocalizations.of(context)!.register_error_email_in_use);
          break;
        case "weak-password":
          setState(() => error = AppLocalizations.of(context)!.register_error_weak_password);
          break;
        default:
          setState(() => error = AppLocalizations.of(context)!.register_error_basic);
          break;
      }
    }
  }
}