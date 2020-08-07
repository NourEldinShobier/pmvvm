import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ProviderExtensions on BuildContext {
  T fetch<T>() => Provider.of<T>(this);
}
