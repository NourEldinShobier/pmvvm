import 'package:example/core/packages.dart';
import 'package:flutter/material.dart';

import '../sign-in.vm.dart';

class SignIn extends StatelessView<SignInPageVM> {
  const SignIn({Key key}) : super(key: key, reactive: false);

  @override
  Widget render(context, page) {
    return Center(
      child: ElevatedButton(
        onPressed: page.signInWithGoogle_onTap,
        child: Text('Sign in with Google'),
      ),
    );
  }
}
