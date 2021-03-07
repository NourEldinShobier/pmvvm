import 'package:flutter/material.dart';
import 'package:example/core/packages.dart';

import '../sign-in.vm.dart';

class Phone extends StatelessView<SignInPageVM> {
  const Phone({Key key}) : super(key: key, reactive: false);

  Widget render(context, page) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Verify Your Phone Number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: page.phoneTextField,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: page.sendCode_onTap,
                child: Text(
                  'Send Code',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
