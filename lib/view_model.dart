import 'dart:async';

import 'package:flutter/material.dart';

import 'models/index.dart';

class ViewModel extends ChangeNotifier {
  /// The context of the view.
  late BuildContext context;

  final _observablesSubcriptions = Map<Observable, StreamSubscription>();

  bool _disposed = false;
  bool get disposed => _disposed;

  /// A callback after the MVVM widget's initState is called.
  ///
  /// See also:
  ///
  ///  * [onDependenciesChange], which is called when the MVVM widget's [didChangeDependencies]
  ///    is called.
  void init() {}

  /// A callback when the MVVM widget's [didChangeDependencies] is called.
  ///
  /// For example, when `context.fetch<T>(listen: true/false)` is used within the view model,
  /// then the [onDependenciesChange] method will be called every time these dependencies change.
  void onDependenciesChange() {}

  /// A callback when the `build` method of the view is called.
  void onBuild() {}

  /// A callback when the view is mounted.
  void onMount() {}

  /// A callback when the view is unmounted
  void onUnmount() {}

  /// A callback when the application is visible and responding
  /// to user input.
  void onResume() {}

  /// A callback when the application is not currently visible to
  /// the user, not responding to user input, and running in the background.
  void onPause() {}

  /// A callback when the application is in an inactive state
  /// and is not receiving user input.
  ///
  /// For `IOS` only.
  void onInactive() {}

  /// A callback when the application is still hosted on a flutter engine
  /// but is detached from any host views.
  ///
  /// For `Android` only.
  void onDetach() {}

  /// Listen to observables changes and call [notifyListeners] when a new value
  /// is added to the stream.
  ///
  /// @param [reset] - whether to reset all the existing observables' listeners
  /// before adding the new ones.
  void observe(List<Observable> observables, {bool reset = true}) {
    if (reset) clearAllObservers();

    observables.forEach((observable) {
      final subscription = observable.stream.listen((_) => notifyListeners());

      _observablesSubcriptions[observable] = subscription;
    });
  }

  /// Stop listening to specific observables
  void unobserve(List<Observable> observables) {
    observables.forEach((observable) {
      final subscription = _observablesSubcriptions[observable];

      subscription?.cancel();

      _observablesSubcriptions.remove(observable);
    });
  }

  /// Stop listening to all observables
  void clearAllObservers() {
    _observablesSubcriptions.forEach((_, subscription) {
      subscription.cancel();
    });

    _observablesSubcriptions.clear();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    clearAllObservers();
    super.dispose();
  }
}
