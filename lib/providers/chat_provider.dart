import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/chat_service.dart';
import 'package:smart_ambulance/services/user_service.dart';

class ChatProvider extends ChangeNotifier {
  late ChatService chatService;
  late UserService userService;
  late UserModel currentUser;
  late List<UserModel> usersToChat;
  late Future getUsersToChat;

  ChatProvider() {
    chatService = ChatService();
    userService = UserService();
    getUsersToChat = getUsersToChatAsync();
  }

  Future getUsersToChatAsync() async {
    currentUser = await userService.getUserDetails();
    var users = await chatService.getUsersForChat();

    usersToChat = users.where((user) => user.role != 0 && user.role != currentUser.role).toList();
  }

  Future sendMessage(String receiverUid, String receiverEmail, String message) async {
    await chatService.sendMessage(receiverUid, message);
  }

  Stream<QuerySnapshot> getMessages(String otherUserId) {
    return chatService.getMessages(otherUserId);
  }
}