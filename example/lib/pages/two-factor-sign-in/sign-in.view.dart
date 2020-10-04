import 'package:example/core/packages.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.module.dart';

import 'sign-in.vm.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MVVM<SignInPageVM>(
      view: (_, __) => _SignInPageView(),
      viewModel: SignInPageVM(),
    );
  }
}

class _SignInPageView extends StatelessView<SignInPageVM> {
  const _SignInPageView({Key key}) : super(key: key);

  Widget render(context, page) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          if (index == 0) return const SignIn();
          if (index == 1) return const Phone();
          if (index == 2) return const Code();
          return null;
        },
        controller: page.pageController,
        itemCount: 3,
      ),
    );
  }
}
