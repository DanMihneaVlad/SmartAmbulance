import 'package:smart_ambulance/constants/collection_paths.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  String userId = AuthService.currentUserId ?? '';

  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future addUser(UserModel user) async {
    try {

      await _firestoreInstance.collection(CollectionPaths.usersForApproval).doc(userId).set(user.toJson());

    } on Exception catch (e) {
      return e;
    }
  }

  Future getUserDetails() async {
    try {

      final response = await _firestoreInstance.collection(CollectionPaths.users).doc(userId).get();

      if (!response.exists) {
        return null;
      }

      final Map<String, dynamic>? user = response.data();

      return UserModel.fromJson(user as Map<String, dynamic>);

    } on Exception catch (e) {
      return e;
    }
  }
}