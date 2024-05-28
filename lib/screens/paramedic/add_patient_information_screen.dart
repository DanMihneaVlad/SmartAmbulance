import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/constants/input_decoration.dart';
import 'package:smart_ambulance/constants/sizes.dart';
import 'package:smart_ambulance/constants/text_styles.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/models/patient/patient_model.dart';
import 'package:smart_ambulance/providers/patient_provider.dart';
import 'package:smart_ambulance/widgets/custom_alert_dialog.dart';
import 'package:smart_ambulance/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_ambulance/widgets/custom_button.dart';
import 'package:smart_ambulance/widgets/custom_image_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class AddPatientInformationScreen extends StatefulWidget {
  const AddPatientInformationScreen({super.key});

  @override
  State<AddPatientInformationScreen> createState() => _AddPatientInformationScreenState();
}

class _AddPatientInformationScreenState extends State<AddPatientInformationScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _cnpController = TextEditingController();
  final _diagnosticController = TextEditingController();
  HospitalModel? _destinationHospital;

  String saveError = '';

  late final PatientProvider patientProvider;

  @override
  void initState() {
    super.initState();

    patientProvider = context.read<PatientProvider>();
  }

  @override
  void dispose() {
    _patientNameController.dispose();
    _cnpController.dispose();
    _diagnosticController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        patientProvider.getHospitals,
        patientProvider.getUserDetails
      ]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: CustomAppBar(title: AppLocalizations.of(context)!.add_patient_information, backButton: true),
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SmartAmbulanceSizes.horizontalPadding, vertical: SmartAmbulanceSizes.verticalPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Patient image
                            Stack(children: [
                              CircleAvatar(
                                radius: 80.0,
                                backgroundImage: _image == null
                                    ? const AssetImage('assets/img/patient.png')
                                    : FileImage(File(_image!.path)) as ImageProvider,
                              ),
                              Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: ((builder) => CustomImageBottomSheet(onPressed: takePhoto, text: AppLocalizations.of(context)!.add_patient_picture)));
                                    },
                                    child: const Icon(Icons.camera_alt)))
                            ]),
                            const SizedBox(height: SmartAmbulanceSizes.smallSizedBox,),
        
                            // Patient name textfield
                            TextFormField(
                              controller: _patientNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length < 2) {
                                  return AppLocalizations.of(context)!.add_patient_error_patient_name;
                                }
                                return null;
                              },
                              decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.add_patient_hint_patient_name),
                              maxLength: 32,
                            ),
                            const SizedBox(height: SmartAmbulanceSizes.smallSizedBox,),
        
                            // CNP textfield
                            TextFormField(
                              controller: _cnpController,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length != 13) {
                                  return AppLocalizations.of(context)!.add_patient_error_cnp;
                                }
                                return null;
                              },
                              decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.add_patient_hint_cnp),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            const SizedBox(height: SmartAmbulanceSizes.smallSizedBox,),
        
                            // Diagnostic textfield
                            TextFormField(
                              controller: _diagnosticController,
                              validator: (value) {
                                if (value == null || value.isEmpty || value.length < 8) {
                                  return AppLocalizations.of(context)!.add_patient_error_diagnostic;
                                }
                                return null;
                              },
                              decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.add_patient_hint_diagnostic),
                              maxLength: 2000,
                            ),
                            const SizedBox(height: SmartAmbulanceSizes.smallSizedBox,),
        
                            DropdownButtonFormField(
                              value: _destinationHospital,
                              validator: (value) {
                                if (value == null) {
                                  return AppLocalizations.of(context)!.add_patient_error_hospital;
                                }
                                return null;
                              },
                              isExpanded: true,
                              onChanged: (HospitalModel? newValue) {
                                _destinationHospital = newValue!;
                              },
                              items: patientProvider.hospitals.map<DropdownMenuItem<HospitalModel>>((HospitalModel value) {
                                return DropdownMenuItem<HospitalModel>(value: value, child: Text(value.name));
                              }).toList(), 
                              decoration: SmartAmbulanceDecoration.inputDecoration(hintText: AppLocalizations.of(context)!.paramedic_map_hint_hospital),
                            ),
                            const SizedBox(height: SmartAmbulanceSizes.mediumSizedBox,),
                          ],
                        ),
                      ),
        
                      // Add patient info button
                      SmartAmbulanceButton(
                        text: AppLocalizations.of(context)!.add_patient_button,
                        fontSize: SmartAmbulanceSizes.bigButtonFontSize,
                        onPressed: () async {
                          await addPatient();
                        },
                      ),
                      const SizedBox(height: SmartAmbulanceSizes.smallSizedBox),
        
                      // Save error
                      Text(
                        saveError,
                        style: SmartAmbulanceTextStyles.errorTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  void takePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> addPatient() async {
    setState(() {
      saveError = '';
    });
    if (_formKey.currentState!.validate()) {
      if (_destinationHospital == null) {
        if (_image == null) {
          setState(() {
            saveError = AppLocalizations.of(context)!.add_patient_error_no_image;
          });
        } else {
          try {
            String patientId = const Uuid().v1();

            dynamic imageUrl = await patientProvider.addImage(_patientNameController.text.trim(), _image);

            PatientModel patient = PatientModel(
              uid: patientId, 
              name: _patientNameController.text.trim(), 
              cnp: _cnpController.text.trim(), 
              diagnostic: _diagnosticController.text.trim(), 
              imageUrl: imageUrl, 
              paramedicName: '${patientProvider.user.firstName} ${patientProvider.user.lastName}', 
              destinationHospital: _destinationHospital!.name
            );

            await patientProvider.addPatientInformation(patient);

            showDialog(
              context: context, 
              builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.add_patient_success)
            );

            clearControllers();
          } catch (e) {
            setState(() {
              saveError = AppLocalizations.of(context)!.add_patient_error;
            });
          }
        }
      }
    }
  }

  void clearControllers() {
    _patientNameController.clear();
    _cnpController.clear();
    _diagnosticController.clear();
    setState(() {
      _image = null;
    });
  }
}