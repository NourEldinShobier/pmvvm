import 'package:flutter/material.dart';
import 'package:example/core/packages.dart';

import 'package:example/models/models.module.dart';
import 'core/services/firebase.service.dart';

import 'app/app.view.dart';

void main() => runApp(const Root());

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Profile>.value(value: authService.profile),
      ],
      child: MyApp(),
    );
  }
}
