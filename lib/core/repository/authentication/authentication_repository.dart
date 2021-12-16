part of 'base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  final BaseFirebaseClient firebaseClient;

  AuthenticationRepository({required this.firebaseClient});

  @override
  Future<User?> signInGoogle() async {
    FirebaseAuth _auth = firebaseClient.initializeAuth();
    User? _user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        _user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      }

      return _user;
    }
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth _auth = firebaseClient.initializeAuth();

    _auth.signOut();
  }
}
