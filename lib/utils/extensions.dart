import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderExtensions on BuildContext {
  T fetch<T>({bool listen = true}) => Provider.of<T>(this, listen: listen);
}
