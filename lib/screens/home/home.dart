import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/enums/user_role_enum.dart';
import 'package:smart_ambulance/providers/user_provider.dart';
import 'package:smart_ambulance/screens/home/admin_home.dart';
import 'package:smart_ambulance/screens/home/doctor_home.dart';
import 'package:smart_ambulance/screens/home/paramedic_home.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();

    return FutureBuilder(
      future: Future.wait([
        userProvider.getUserDetails
      ]), 
      builder: (BuildContext ctx, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.done) {
          if (asyncSnapshot.hasError) {
            return Scaffold(
              appBar: CustomAppBar(title: AppLocalizations.of(context)!.home_error_loading_data, backButton: false, signOutButton: true),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(child: Image.asset('assets/img/home.png')),
                    const SizedBox(height: SmartAmbulanceSizes.bigSizedBox,),
                    Text(textAlign: TextAlign.center, style: SmartAmbulanceTextStyles.errorTextStyle, AppLocalizations.of(context)!.user_not_approved),
                  ],
                )
              )
            );
          } else {
            return _getHomePage(userProvider.user.role);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _getHomePage(int role) {
    if (role == UserRole.doctor.id) {
      return const DoctorHomePage();
    } else {
      if (role == UserRole.paramedic.id) {
        return const ParamedicHomePage(); 
      } else {
        if (role == 0) {
          return const AdminHomePage();
        }
      }
    }
    
    return Center(child: Text(AppLocalizations.of(context)!.user_not_approved));
  }

}