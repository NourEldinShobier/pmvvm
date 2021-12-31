import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  /// The context of the view.
  late BuildContext context;

  bool _disposed = false;
  bool get disposed => _disposed;

  /// - A callback after [ViewModel] is constructed.
  /// - The event is called by default every time the
  ///   [ViewModel] view dependencies are updated.
  /// - Set `initOnce` of the `MVVM` builder to `true` to ignore
  ///   dependencies updates.
  void init() {}

  /// A callback when the `build` method is called.
  void onBuild() {}

  /// A callback when the view disposed.
  void onDispose() {}

  /// A callback when the application is visible and responding
  /// to user input.
  void onResume() {}

  /// A callback when the application is not currently visible to
  /// the user, not responding to user input, and running in the background.
  void onPause() {}

  /// - A callback when the application is in an
  ///   inactive state and is not receiving user input.
  /// - For `IOS` only.
  void onInactive() {}

  /// - A callback when the application is still hosted
  ///   on a flutter engine but is detached from any host views.
  /// - For `Android` only.
  void onDetach() {}

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
