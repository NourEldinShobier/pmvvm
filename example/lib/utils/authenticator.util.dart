import 'package:example/core/packages.dart';
import 'package:example/utils/utils.module.dart';

abstract class Authenticator {
  static Future<bool> isSignedInAndVerified(FirebaseUser user) async {
    if (isSignedIn(user)) {
      if (await isVerified(user)) {
        return Future.value(true);
      }
    }

    return Future.value(false);
  }

  static bool isSignedIn(FirebaseUser user) {
    return user != null;
  }

  static Future<bool> isVerified(FirebaseUser user) async {
    var profile = await UserDAO.getProfile(user);
    return Future.value(profile.verified);
  }
}
