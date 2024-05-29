import 'package:flutter/material.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/models/patient/patient_model.dart';

class CustomPatientCard extends StatelessWidget {
  const CustomPatientCard({super.key, required this.patient});

  final PatientModel patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SmartAmbulanceSizes.cardPadding),
      child: Container(
        height: 220,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(SmartAmbulanceSizes.borderRadius)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 194, 194, 194),
              spreadRadius: 1.5,
              blurRadius: 5
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.cardPadding, vertical: SmartAmbulanceSizes.cardVerticalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                patient.name,
                style: SmartAmbulanceTextStyles.cardTitleTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SmartAmbulanceSizes.smallSizedBox,),

              Row(
                children: [
                  Image.network(
                    patient.imageUrl,
                    height: 120,
                    width: 130,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) {
                      return const Image(image: AssetImage('assets/img/patient.png'),);
                    },
                  ),

                  Padding(padding: const EdgeInsets.only(left: SmartAmbulanceSizes.cardVerticalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient.cnp
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            patient.destinationHospital
                          ),
                        ),
                        Text(
                          patient.paramedicName
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            patient.diagnostic
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}