import 'package:example/core/packages.dart';
import 'package:example/core/services/firebase.service.dart';
import 'package:flutter/material.dart';

import 'package:example/pages/pages.module.dart';

import 'app.vm.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => _MyAppView(),
      viewModel: () => AppVM(),
    );
  }
}

class _MyAppView extends StatelessView<AppVM> {
  const _MyAppView({Key key}) : super(key: key);

  @override
  Widget render(context, app) {
    return MaterialApp(
      title: app.title,
      home: app.authStatus != AuthStatus.DONE ? SignInPage() : CounterPage(),
    );
  }
}
