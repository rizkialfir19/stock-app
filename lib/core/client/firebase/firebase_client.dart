import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stock_app/core/core.dart';

class FirebaseClient extends BaseFirebaseClient {
  FirebaseClient._createInstance();

  static final FirebaseClient _instance = FirebaseClient._createInstance();
  static FirebaseClient get instance => _instance;

  FirebaseApp? _firebaseApp;

  @override
  Future<void> initializeApp() async {
    _firebaseApp = await Firebase.initializeApp();
  }

  @override
  FirebaseAuth initializeAuth() {
    return FirebaseAuth.instance;
  }
}
