import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_ambulance/models/user/user_model.dart';
import 'package:smart_ambulance/services/user_service.dart';

class AuthService {

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? get currentUserId => _auth.currentUser?.uid;

  Future signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future register(String email, String password, String confirmedPassword, String firstName, String lastName, int role) async {
    try {

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );

      User? registeredUser = userCredential.user;

      String uid = currentUserId ?? '';

      if (registeredUser != null) {
        UserModel user = UserModel(uid: uid, email: email, firstName: firstName, lastName: lastName, role: role);
        
        await UserService().addUser(user);
      }

    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future resetPassword(String email) async {
    try {

      await _auth.sendPasswordResetEmail(email: email);

    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  Future signOut() async {
    try {

      return await _auth.signOut();

    } catch (e) {
      return null;
    }
  }

}