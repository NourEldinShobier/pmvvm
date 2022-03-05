import 'package:flutter/widgets.dart';
import 'package:pmvvm/models/index.dart';
import 'package:provider/provider.dart';

extension ProviderExtensions on BuildContext {
  T fetch<T>({bool listen = true}) => Provider.of<T>(this, listen: listen);
}

extension ObjectExtension<T> on T {
  Observable<T> observable([String? alias]) => Observable<T>.initialized(this, alias);
}
