import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/constants/collection_paths.dart';
import 'package:smart_ambulance/models/destination/destination_model.dart';
import 'package:smart_ambulance/services/auth_service.dart';

class DestinationService {
  
  String userId = AuthService.currentUserId ?? '';

  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future getUserDestination() async {
    try {

      final response = await _firestoreInstance.collection(CollectionPaths.destinations).where("userUid", isEqualTo: userId).get();

      if (response.docs.isEmpty) {
        return DestinationModel(uid: '', userUid: userId, hospitalUid: '', latStart: 0, lngStart: 0, latCurrent: 0, lngCurrent: 0, latDestination: 0, lngDestination: 0, paramedicName: '');
      }

      final Map<String, dynamic> destination = response.docs[0].data();
      
      return DestinationModel.fromJson(destination);

    } on Exception catch (e) {
      return e;
    }
  }

  Future setDestination(DestinationModel destinationModel) async {
    try {

      await _firestoreInstance.collection(CollectionPaths.destinations).doc(destinationModel.uid).set(destinationModel.toJson());

      final response = await _firestoreInstance.collection(CollectionPaths.destinations).where("userUid", isEqualTo: userId).get();

      if (response.docs.isEmpty) {
        return DestinationModel(uid: '', userUid: userId, hospitalUid: '', latStart: 0, lngStart: 0, latCurrent: 0, lngCurrent: 0, latDestination: 0, lngDestination: 0, paramedicName: '');
      }

      final Map<String, dynamic> destination = response.docs[0].data();
      
      return DestinationModel.fromJson(destination);

    } on Exception catch (e) {
      return e;
    }
  }

  Future updateLocation(DestinationModel destinationModel) async {
    try {
      
      final destinationRef = _firestoreInstance.collection(CollectionPaths.destinations).doc(destinationModel.uid);
      destinationRef.update({
        "latCurrent": destinationModel.latCurrent,
        "lngCurrent": destinationModel.lngCurrent
      });

    } on Exception catch (e) {
      return e;
    }
  }

  Future stopTravelling(DestinationModel destinationModel) async {
    try {

      await _firestoreInstance.collection(CollectionPaths.destinations).doc(destinationModel.uid).delete();

    } on Exception catch (e) {
      return e;
    }
  }

  Future getParamedicDestinations() async {
    List<DestinationModel> paramedicDestinations = [];

    var destinations = await _firestoreInstance.collection(CollectionPaths.destinations).get();
    final data = destinations.docs.map((doc) => doc.data()).toList();

    for (Map<String, dynamic>? elem in data) {
      DestinationModel hospital = DestinationModel.fromJson(elem as Map<String, dynamic>);
      paramedicDestinations.add(hospital);
    }

    return paramedicDestinations;
  }

  Stream<QuerySnapshot> getDestinationUpdates() {
    return _firestoreInstance
      .collection(CollectionPaths.destinations)
      .snapshots();
  }
}