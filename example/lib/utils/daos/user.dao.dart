import 'package:example/core/packages.dart';
import 'package:example/models/models.module.dart';

abstract class UserDAO {
  static var _db = Firestore.instance;

  static void updateUser(FirebaseUser user, Map<String, dynamic> data) {
    DocumentReference ref = _db.collection('users').document(user.uid);

    ref.setData(data, merge: true);
  }

  static Future<Profile> getProfile(FirebaseUser user) async {
    var snapshot = await _db.collection('users').document(user.uid).get();

    return Future.value(Profile.fromMap(snapshot.data));
  }
}
