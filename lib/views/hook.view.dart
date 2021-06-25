import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

abstract class HookView<T extends ViewModel> extends HookWidget {
  const HookView({Key? key, this.reactive = true}) : super(key: key);

  final bool reactive;

  @override
  Widget build(BuildContext context) =>
      render(context, Provider.of<T>(context, listen: reactive));

  Widget render(BuildContext context, T viewModel);
}
