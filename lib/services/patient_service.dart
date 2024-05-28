import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_ambulance/constants/collection_paths.dart';
import 'package:smart_ambulance/models/patient/patient_model.dart';
import 'package:smart_ambulance/services/auth_service.dart';

class PatientService {

  String userId = AuthService.currentUserId ?? '';

  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  static final FirebaseStorage _storageInstance = FirebaseStorage.instance;

  Future addPatient(PatientModel patient) async {
    try {

      await _firestoreInstance.collection(CollectionPaths.patients).doc(patient.uid).set(patient.toJson());

    } on Exception catch (e) {
      return e;
    }
  }

  Future addImage(String patientName, XFile? image) async {
    String url = '';

    try {
      if (image != null) {
        final ref = _storageInstance.ref().child('patientImages').child('$userId$patientName${Timestamp.now()}.jpg');
        await ref.putFile(File(image.path));
        url = await ref.getDownloadURL();

        return url;
      }
    } on Exception catch (e) {
      return e;
    }
  }
}