import 'package:example/core/packages.dart';
import 'package:example/models/models.module.dart';
import 'package:example/utils/utils.module.dart';

class AppVM extends ViewModel {
  Profile profile;
  bool isSignedInAndVerified = false;

  var title = 'PMVVM Example';

  @override
  void init() {
    profile = Provider.of<Profile>(context);

    if (Authenticator.isSignedInAndVerified(profile)) {
      isSignedInAndVerified = true;
      notifyListeners();
    } else {
      isSignedInAndVerified = false;
      notifyListeners();
    }
  }
}
