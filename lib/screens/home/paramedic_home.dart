import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/providers/destination_provider.dart';
import 'package:smart_ambulance/providers/patient_provider.dart';
import 'package:smart_ambulance/screens/paramedic/add_patient_information_screen.dart';
import 'package:smart_ambulance/screens/paramedic/chat_widget.dart';
import 'package:smart_ambulance/screens/paramedic/paramedic_map_screen.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';

class ParamedicHomePage extends StatefulWidget {
  const ParamedicHomePage({super.key});

  @override
  State<ParamedicHomePage> createState() => _ParamedicHomePageState();
}

class _ParamedicHomePageState extends State<ParamedicHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.paramedic_home, backButton: false, signOutButton: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding / 2, vertical: SmartAmbulanceSizes.verticalPadding),
          child: Column(
            children: [
              const ChatWidget(),

              const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SmartAmbulanceButton(text: AppLocalizations.of(context)!.paramedic_home_map_button, fontSize: SmartAmbulanceSizes.smallButtonFontSize, onPressed: (() async {
                    await goToMapPage();
                  }),),
                  SmartAmbulanceButton(text: AppLocalizations.of(context)!.paramedic_home_add_patient, fontSize: SmartAmbulanceSizes.smallButtonFontSize, onPressed: (() async {
                    await goToAddPatientInformationPage();
                  }),)
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> goToMapPage() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<DestinationProvider>(),
        child: const ParamedicMapScreen(),
      )
    ));
  }

  Future<void> goToAddPatientInformationPage() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider.value(
        value: context.read<PatientProvider>(),
        child: const AddPatientInformationScreen(),
      )
    ));
  }
}