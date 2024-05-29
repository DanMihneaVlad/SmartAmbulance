import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/models/patient/patient_model.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/hospital_service.dart';
import 'package:smart_ambulance/services/patient_service.dart';
import 'package:smart_ambulance/services/user_service.dart';

class PatientProvider extends ChangeNotifier {
  late PatientService patientService;
  late HospitalService hospitalService;
  late UserService userService;
  late Future getHospitals;
  late Future getUserDetails;
  late Future getPatientsInformation;
  late List<HospitalModel> hospitals = [];
  late List<PatientModel> patients = [];
  late UserModel user;

  PatientProvider() {
    patientService = PatientService();
    hospitalService = HospitalService();
    userService = UserService();
    getHospitals = getHospitalsFuture();
    getUserDetails = getUserDetailsFuture();
    getPatientsInformation = getPatientsInformationFuture();
  }

  Future getHospitalsFuture() async {
    hospitals = await hospitalService.getHospitals();
  }

  Future getUserDetailsFuture() async {
    user = await userService.getUserDetails();
  }

  Future addImage(String patientName, XFile? image) async {
    try {
      String imageUrl = await patientService.addImage(patientName, image);

      return imageUrl;
    } on Exception {
      throw Exception("Could not save image");
    }
  }

  Future addPatientInformation(PatientModel patient) async {
    await patientService.addPatient(patient);
  }

  Future getPatientsInformationFuture() async {
    try {
      patients = await patientService.getPatientsInformation();
    } on Exception catch (e) {
      print('Error retrieving the patients');
    }
  }
}