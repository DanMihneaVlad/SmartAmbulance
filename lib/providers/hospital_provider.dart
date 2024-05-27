import 'package:flutter/material.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/services/hospital_service.dart';

class HospitalProvider extends ChangeNotifier {
  late HospitalService hospitalService;
  late List<HospitalModel> hospitals = [];
  late Future getHospitals;

  HospitalProvider() {
    hospitalService = HospitalService();
    getHospitals = _getHospitalsFuture();
  }

  Future _getHospitalsFuture() async {
    hospitals = await hospitalService.getHospitals();
  }
}