import 'package:flutter/material.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  late UserService userService;
  late UserModel user;
  List<UserModel> usersForApproval = [];
  late Future getUserDetails;
  late Future getUsersForApproval;

  UserProvider() {
    userService = UserService();
    getUserDetails = _getUserDetailsFuture();
    getUsersForApproval = _getUsersForApproval();
  }

  Future _getUserDetailsFuture() async {
    user = await userService.getUserDetails();
  }

  Future _getUsersForApproval() async {
    usersForApproval = await userService.getUsersForApproval();
  }

  Future<void> approveUser(UserModel user) async{
    await userService.approveUser(user);
    usersForApproval.remove(user);
    notifyListeners();
  }
}