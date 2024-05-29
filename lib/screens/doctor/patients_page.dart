import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/providers/patient_provider.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_patient_card.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  late final PatientProvider patientProvider;

  @override
  void initState() {
    super.initState();

    patientProvider = context.read<PatientProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        patientProvider.getPatientsInformation
      ]), 
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        return Scaffold(
          appBar: CustomAppBar(title: AppLocalizations.of(context)!.patients_page, backButton: true),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding / 2, vertical: SmartAmbulanceSizes.verticalPadding),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: patientProvider.patients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomPatientCard(patient: patientProvider.patients[index],);
                    }
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}