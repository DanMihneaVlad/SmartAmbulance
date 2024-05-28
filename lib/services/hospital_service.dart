import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/constants/collection_paths.dart';
import 'package:smart_ambulance/models/hospital/hospital_model.dart';
import 'package:smart_ambulance/services/auth_service.dart';

class HospitalService {

  String userId = AuthService.currentUserId ?? '';

  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<List<HospitalModel>> getHospitals() async {

    try {

      List<HospitalModel> hospitals = [];

      final response = await _firestoreInstance.collection(CollectionPaths.hospitals).get();
      final data = response.docs.map((doc) => doc.data()).toList();

      if (data.isEmpty) {
        return hospitals;
      }

      for (Map<String, dynamic>? elem in data) {
        HospitalModel hospital = HospitalModel.fromJson(elem as Map<String, dynamic>);
        hospitals.add(hospital);
      }

      return hospitals;

    } on Exception {
      rethrow;
    }

  }

  Future addHospital(name, address) async{
     HospitalModel hospital = HospitalModel(uid: "123445", name: name, address: address , lat:0,lng: 0);
     
    try {
      // Add the hospital to the hospitals collection in Firestore
      await _firestoreInstance.collection(CollectionPaths.hospitals).add(hospital.toJson());
      print('Hospital added successfully');
    } catch (e) {
      print('Error adding hospital: $e');
    }
  }
}