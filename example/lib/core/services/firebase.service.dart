import 'dart:async';
import 'package:example/core/packages.dart';
import 'package:example/models/models.module.dart';

final authService = AuthService();

class AuthService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final _db = Firestore.instance;

  Stream<Profile> _profile;

  AuthService() {
    _profile = user.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db
            .collection('users')
            .document(u.uid)
            .snapshots()
            .map((snap) => Profile.fromMap(snap.data));
      } else {
        return Stream.value(null);
      }
    });
  }

  // methods

  Future<FirebaseUser> googleSignIn() async {
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

  Future<void> _saveUserProfile(FirebaseUser user) async {
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

  Future<void> verifyPhoneNumber({
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
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  // getters

  Future<FirebaseUser> get currentUser => _auth.currentUser();
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;
  Stream<Profile> get profile => _profile;
}
