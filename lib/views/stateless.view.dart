import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

abstract class StatelessView<T> extends StatelessWidget {
  const StatelessView({Key? key, this.reactive = true});

  final bool reactive;

  @override
  Widget build(context) =>
      render(context, Provider.of<T>(context, listen: reactive));

  Widget render(BuildContext context, T viewModel);
}
