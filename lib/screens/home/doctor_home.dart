import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/screens/paramedic/chat_widget.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.doctor_home, backButton: false, signOutButton: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding / 2, vertical: SmartAmbulanceSizes.verticalPadding),
          child: Column(
            children: [
              const ChatWidget(),

              const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox,),

              
            ],
          ),
        )
      ),
    );
  }
}