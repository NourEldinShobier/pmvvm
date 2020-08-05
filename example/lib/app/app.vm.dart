import 'package:example/core/packages.dart';
import 'package:example/core/services/firebase.service.dart';
import 'package:example/utils/utils.module.dart';

class AppVM extends ViewModel {
  FirebaseUser user;
  AuthStatus authStatus;

  var title = 'PMVVM Example';

  @override
  void init() {
    user = Provider.of<FirebaseUser>(context);
    authStatus = Provider.of<AuthStatus>(context);

    checkSignInOrNot();
  }

  Future<void> checkSignInOrNot() async {
    if (await Authenticator.isSignedInAndVerified(user)) {
      AuthService.authStatusController.add(AuthStatus.DONE);
    }
  }
}
