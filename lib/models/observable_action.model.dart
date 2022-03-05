import 'package:tint/tint.dart';

/// A class that wraps the observable's action, value, time, and the
/// observable alias value
class ObservableAction<T> {
  ObservableAction({
    required this.value,
    required this.dateTime,
    this.action,
    String? alias,
  }) : _alias = alias;

  final T value;
  final DateTime dateTime;
  final String? action;
  final String? _alias;

  @override
  String toString() {
    final $type = ' type: ${T.toString()} |'.white().bold();
    final $leading = '[ACTION]'.rgb(r: 2, g: 242, b: 144).bold();
    final $alias = ' alias: $_alias |'.white().bold();
    final $value = ' value: $value |'.white().bold();
    final $action = ' action: $action |'.white().bold();
    final $at = ' at: $dateTime'.white().bold();

    return '${$leading}${$type}${$alias}${$value}${$action}${$at}';
  }
}
