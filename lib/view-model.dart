import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  BuildContext context;

  bool _initialized = false;
  bool get initialized => _initialized;

  bool _disposed = false;
  bool get disposed => _disposed;

  @protected
  void init() {}
  @protected
  void build() {}

  /// This is only called the first time the viewmodel is initialized.
  set setInit(bool value) => _initialized = value;

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
