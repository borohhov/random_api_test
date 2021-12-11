import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> signInAnonymously() async{
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user?.uid;
  }

  Stream<User?> listenToAuth() {
    return FirebaseAuth.instance
        .userChanges();
  }
}