// ignore_for_file: close_sinks

import 'dart:async';
import 'package:example/core/packages.dart';

enum AuthStatus { DONE, NOT_DONE }

class AuthService {
  static final _googleSignIn = GoogleSignIn();
  static final _auth = FirebaseAuth.instance;
  static final _db = Firestore.instance;

  static var authStatusController = StreamController<AuthStatus>();

  // methods

  static Future<FirebaseUser> googleSignIn() async {
    try {
      var googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount == null) return null;

      var googleAuth = await googleSignInAccount.authentication;
      var credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var user = (await _auth.signInWithCredential(credential)).user;

      _saveUserProfile(user);

      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<void> _saveUserProfile(FirebaseUser user) async {
    if (user != null) {
      var ref = _db.collection('users').document(user.uid);

      return ref.setData({
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoUrl,
        'displayName': user.displayName,
        'phoneNumber': '',
        'verified': false,
        'lastSeen': DateTime.now(),
      }, merge: true);
    }
  }

  static Future<void> verifyPhoneNumber({
    String phoneNumber,
    PhoneCodeSent codeSent,
    PhoneVerificationFailed verificationFailed,
    PhoneVerificationCompleted verificationCompleted,
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(minutes: 1),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }

  // getters

  static Future<FirebaseUser> get currentUser => _auth.currentUser();
  static Stream<FirebaseUser> get user => _auth.onAuthStateChanged;
  static Stream<AuthStatus> get authStatus => authStatusController.stream;
}
