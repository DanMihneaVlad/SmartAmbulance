import 'package:flutter/material.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  late UserService userService;
  late UserModel user;
  late Future getUserDetails;

  UserProvider() {
    userService = UserService();
    getUserDetails = _getUserDetailsFuture();
  }

  Future _getUserDetailsFuture() async {
    user = await userService.getUserDetails();
  }
}