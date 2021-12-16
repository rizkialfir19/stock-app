import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stock_app/core/core.dart';

part 'authentication_repository.dart';

abstract class BaseAuthenticationRepository {
  Future<User?> signInGoogle();

  Future<void> signOut();
}
