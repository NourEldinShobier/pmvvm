import 'package:pmvvm/pmvvm.dart';

class CounterPageVM extends ViewModel {
  var title = 'Counter';

  // final counter = Observable.initialized(0);
  final counter = 0.observable('MyCounter');

  @override
  void init() {
    observe([counter]);
  }

  void increase() {
    counter.setValue(counter.value + 1, action: 'INCREASE');
  }
}
