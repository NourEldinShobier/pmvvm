import 'package:example/models/models.module.dart';

abstract class Authenticator {
  static bool isSignedInAndVerified(Profile profile) {
    if (isSignedIn(profile)) {
      if (profile.verified) return true;
    }

    return false;
  }

  static bool isSignedIn(Profile profile) {
    return profile != null;
  }
}
