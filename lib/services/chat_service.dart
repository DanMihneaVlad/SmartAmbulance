import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/constants/collection_paths.dart';
import 'package:smart_ambulance/models/message/message_model.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/auth_service.dart';

class ChatService {

  String userId = AuthService.currentUserId ?? '';
  String userEmail = AuthService.currentUserEmail ?? '';

  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  
  Future<List<UserModel>> getUsersForChat() async {
    List<UserModel> userList = [];

    try {
      final usersSnapshot = await _firestoreInstance.collection(CollectionPaths.approvedUsers).get();
      
      final usersData = usersSnapshot.docs.map((doc) => doc.data()).toList();

      for (Map<String, dynamic>? userMap in usersData) {
        UserModel user = UserModel.fromJson(userMap as Map<String, dynamic>);
        userList.add(user);
      }

    } catch (e) {
      print('Error fetching users: $e');
    }

    return userList;
  }

  Future sendMessage(String receiverUid, String message) async {
    final DateTime timestamp = DateTime.now();

    MessageModel messageModel = MessageModel(
      senderUid: userId, 
      senderEmail: userEmail, 
      receiverUid: receiverUid, 
      message: message, 
      timestamp: timestamp
    );

    List<String> ids = [userId, receiverUid];
    ids.sort(); // make sure 2 people have the same chatroomId
    String chatRoomId = ids.join('_');

    // save message to firestore
    await _firestoreInstance.collection(CollectionPaths.chatRooms).doc(chatRoomId).collection(CollectionPaths.messages).add(messageModel.toJson());
  }
}