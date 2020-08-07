import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

abstract class HookView<T> extends HookWidget {
  const HookView({Key key, this.reactive = true});

  final bool reactive;

  @override
  Widget build(context) =>
      render(context, Provider.of<T>(context, listen: reactive));

  Widget render(BuildContext context, T viewModel);
}
