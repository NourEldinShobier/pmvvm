import 'package:example/core/packages.dart';
import 'package:flutter/material.dart';

import 'app/app.view.dart';
import 'core/services/firebase.service.dart';

void main() => runApp(const Root());

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService.user),
        StreamProvider<AuthStatus>.value(
          value: AuthService.authStatus,
          initialData: AuthStatus.NOT_DONE,
        ),
      ],
      child: MyApp(),
    );
  }
}
