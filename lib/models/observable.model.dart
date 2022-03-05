import 'dart:async';

import 'package:pmvvm/pmvvm.dart';

typedef void ValueChangedCallback<T>(
  ObservableAction<T> newAction,
  ObservableAction<T>? prevAction,
);

/// A data wrapper class that helps with keep track of any actions applied to any
/// data/state, it can also store a history of all actions applied to this data.
class Observable<T> {
  Observable([this.alias]);

  Observable.initialized(T value, [this.alias]) {
    final observableAction = ObservableAction(
      value: value,
      dateTime: DateTime.now(),
      action: 'INITIAL_VALUE',
      alias: this.alias,
    );

    _addAction(observableAction);
  }

  final String? alias;

  final _history = <ObservableAction<T>>[];
  final _streamController = StreamController<ObservableAction<T>>.broadcast();

  late T _value;

  ValueChangedCallback<T>? _logCallback;

  bool _hasValue = false;

  /// getters

  T? get prevValue => _prevAction?.value;

  T get value {
    if (!_hasValue) {
      throw Exception('[PMVVM] Observable has no value. You should check if observable.hasValue '
          'before accessing its value, or use observable.valueOrNull instead.');
    }

    return _value;
  }

  T? get valueOrNull {
    if (!_hasValue) return null;

    return _value;
  }

  bool get hasValue => _hasValue;

  List<ObservableAction<T>> get history => _history;

  Stream<T> get stream => _streamController.stream.map((action) => action.value);

  bool get _hasPrevAction {
    if (_history.length < 2) return false;

    return true;
  }

  ObservableAction<T>? get _prevAction {
    if (_hasPrevAction) return _history[_history.length - 2];

    return null;
  }

  /// methods

  T? valueOrDefault(T defaultValue) {
    if (!_hasValue) return defaultValue;

    return _value;
  }

  void setValue(T value, {required String action}) {
    final observableAction = ObservableAction(
      value: value,
      dateTime: DateTime.now(),
      action: action,
      alias: this.alias,
    );

    _addAction(observableAction);
  }

  void log(ValueChangedCallback<T> callback) => _logCallback = callback;

  void clearHistory() => _history.clear();

  void resetLogCallback() => _logCallback = null;

  void _addAction(ObservableAction<T> action) {
    _value = action.value;
    _hasValue = true;

    if (PMVVMConfig.trackObservablesHistory) _history.add(action);
    _streamController.sink.add(action);

    _logAction(action);
  }

  void _logAction(ObservableAction<T> action) {
    if (PMVVMConfig.enableLogging) {
      if (_logCallback != null) {
        _logCallback?.call(action, _prevAction);
      } else {
        print(action);
      }
    }
  }
}
