import 'package:pmvvm/pmvvm.dart';

class CounterPageVM extends ViewModel {
  var title = 'Counter';
  var counter = 0;

  void increase() {
    counter++;
    notifyListeners();
  }
}
