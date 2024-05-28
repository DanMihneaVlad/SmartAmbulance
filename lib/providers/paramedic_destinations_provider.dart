import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/models/destination/destination_model.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/services/destination_service.dart';
import 'package:smart_ambulance/services/hospital_service.dart';

class ParamedicDestinationsProvider extends ChangeNotifier {
  late DestinationService destinationService;
  late HospitalService hospitalService;
  late Future getDestinations;
  late Future getHospitals;
  late List<DestinationModel> destinations = [];
  late List<HospitalModel> hospitals = [];

  ParamedicDestinationsProvider() {
    destinationService = DestinationService();
    hospitalService = HospitalService();
    getHospitals = getHospitalsFuture();
    getDestinations = getParamedicDestinationsFuture();
  }

  Future getHospitalsFuture() async {
    hospitals = await hospitalService.getHospitals();
  }

  Future getParamedicDestinationsFuture() async {
    destinations = await destinationService.getParamedicDestinations();
  }

  Stream<QuerySnapshot> getDestinationUpdates() {
    return destinationService.getDestinationUpdates();
  }
}