import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class BaseVm extends ViewModel {
  int counter = 0;

  void increase() {
    counter++;
    notifyListeners();
  }
}

class DependentVm extends ViewModel {
  late int value;

  @override
  void init() {
    value = context.fetch<ValueNotifier<int>>().value;
  }
}
