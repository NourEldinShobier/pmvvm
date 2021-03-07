import 'package:example/core/packages.dart';
import 'package:flutter/material.dart';

import '../sign-in.vm.dart';

class Code extends StatelessView<SignInPageVM> {
  const Code({Key key}) : super(key: key, reactive: false);

  Widget render(context, page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Waiting For Verification Code',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 64),
          Selector<SignInPageVM, int>(
            selector: (_, page) => page.timerValue,
            builder: (_, data, __) {
              return Text(
                data.toString(),
                style: TextStyle(fontSize: 16),
              );
            },
          ),
          const SizedBox(height: 72),
          Selector<SignInPageVM, int>(
            selector: (_, page) => page.timerValue,
            builder: (_, data, __) {
              return ElevatedButton(
                onPressed: data < 1 ? page.sendCode_onTap : null,
                child: Text(
                  'Resend Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
