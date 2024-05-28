import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ambulance/models/destination/destination_model.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/destination_service.dart';
import 'package:smart_ambulance/services/hospital_service.dart';
import 'package:smart_ambulance/services/user_service.dart';
import 'package:uuid/uuid.dart';

class DestinationProvider extends ChangeNotifier {
  late HospitalService hospitalService;
  late DestinationService destinationService;
  late UserService userService;
  late List<HospitalModel> hospitals = [];
  late DestinationModel userDestination;
  late String paramedicName;
  late Future getHospitals;
  late Future getDestination;
  late Future getUserName;

  DestinationProvider() {
    hospitalService = HospitalService();
    destinationService = DestinationService();
    userService = UserService();
    getHospitals = _getHospitalsFuture();
    getDestination = _getDestinationFuture();
    getUserName = _getUserName();
  }

  Future _getUserName() async {
    UserModel user = await userService.getUserDetails();
    paramedicName = '${user.firstName} ${user.lastName}';
  }

  Future _getHospitalsFuture() async {
    hospitals = await hospitalService.getHospitals();
  }

  Future _getDestinationFuture() async {
    userDestination = await destinationService.getUserDestination();
  }

  Future setDestination(double latCurrent, double lngCurrent, HospitalModel destinationHospital) async {
    String destinationId = const Uuid().v1();
    userDestination.uid = destinationId;
    userDestination.hospitalUid = destinationHospital.uid;
    userDestination.latStart = latCurrent;
    userDestination.lngStart = lngCurrent;
    userDestination.latCurrent = latCurrent;
    userDestination.lngCurrent = lngCurrent;
    userDestination.latDestination = destinationHospital.lat;
    userDestination.lngDestination = destinationHospital.lng;
    userDestination.paramedicName = paramedicName;

    userDestination = await destinationService.setDestination(userDestination);

    notifyListeners();
  }

  Future updateLocation(LatLng position) async {
    userDestination.latCurrent = position.latitude;
    userDestination.lngCurrent = position.longitude;

    await destinationService.updateLocation(userDestination);
  }

  Future stopTravelling() async {
    await destinationService.stopTravelling(userDestination);

    userDestination = DestinationModel(uid: '', userUid: destinationService.userId, hospitalUid: '', latStart: 0, lngStart: 0, latCurrent: 0, lngCurrent: 0, latDestination: 0, lngDestination: 0, paramedicName: '');
  }
}