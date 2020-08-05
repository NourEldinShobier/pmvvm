// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:example/core/packages.dart';
import 'package:example/core/services/firebase.service.dart';
import 'package:example/utils/utils.module.dart';
import 'package:flutter/material.dart';

class SignInPageVM extends ViewModel {
  FirebaseUser user;
  AuthStatus authStatus;

  int timerValue = 0;
  Timer timer;

  var pageController = PageController(initialPage: 0);
  var phoneTextField = TextEditingController(text: 'E.g: +123 456 7890');

  @override
  void init() {
    user = Provider.of<FirebaseUser>(context);
    authStatus = Provider.of<AuthStatus>(context);
  }

  // Events

  Future<void> signInWithGoogle_onTap() async {
    var u = await AuthService.googleSignIn();

    if (u != null) {
      _moveToPage(1); //PHONE PAGE
    }
  }

  Future<void> sendCode_onTap() async {
    await AuthService.verifyPhoneNumber(
      codeSent: _codeSent,
      phoneNumber: phoneTextField.text.trim(),
      verificationFailed: _verificationFailed,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      verificationCompleted: _verificationCompleted,
    );
  }

  // Methods

  void _moveToPage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _startTimer() {
    timerValue = 60;

    timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        if (timerValue < 1) {
          timer.cancel();
        } else {
          timerValue -= 1;
          notifyListeners();
        }
      },
    );
  }

  void _codeAutoRetrievalTimeout(String code) {
    print('Code Auto Retrieval Timeout: $code');
  }

  void _codeSent(String code, [int forceResendingToken]) {
    print('Code Sent: $code');

    _moveToPage(2); //CODE PAGE
    _startTimer();
  }

  void _verificationFailed(AuthException authException) {
    _moveToPage(1); //PHONE PAGE
  }

  void _verificationCompleted(_) {
    print('Verification Completed');

    UserDAO.updateUser(user, {
      'phoneNumber': phoneTextField.text.trim(),
      'verified': true,
    });

    AuthService.authStatusController.add(AuthStatus.DONE);
    notifyListeners();
  }
}
