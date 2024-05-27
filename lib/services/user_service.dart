//import 'dart:js_interop_unsafe';

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

      final response = await _firestoreInstance.collection(CollectionPaths.approvedUsers).doc(userId).get();

      if (!response.exists) {
        return null;
      }

      final Map<String, dynamic>? user = response.data();
      
      return UserModel.fromJson(user as Map<String, dynamic>);

    } on Exception catch (e) {
      return e;
    }
  }

  Future<List<UserModel>> getUsersForApproval() async {
    List<UserModel> userList = [];

    try {
      final querySnapshot = await _firestoreInstance.collection('usersForApproval').get();
      
      final data = querySnapshot.docs.map((doc) => doc.data()).toList();

      for (Map<String, dynamic>? elem in data) {
        UserModel user = UserModel.fromJson(elem as Map<String, dynamic>);
        userList.add(user);
      }
    } catch (e) {
      print('Error fetching users: $e');
    }

    return userList;
  }

  Future<void> approveUser(UserModel userForApproval) async {
    
      final response = await _firestoreInstance.collection(CollectionPaths.usersForApproval).doc(userForApproval.uid).get();

      final Map<String, dynamic> user = response.data() as Map<String, dynamic>;

      // Add the user data to the 'approvedUsers' collection
      await _firestoreInstance.collection(CollectionPaths.approvedUsers).doc(userForApproval.uid).set(user);

      _firestoreInstance.collection(CollectionPaths.usersForApproval).doc(userForApproval.uid).delete();

  }

}