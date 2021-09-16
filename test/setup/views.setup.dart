import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

import 'view_model.setup.dart';

/// Reactive views.

class ReactiveView extends StatelessView<BaseVm> {
  ReactiveView({Key? key}) : super(key: key, reactive: true);

  Widget render(BuildContext context, BaseVm vm) {
    return Text(
      vm.counter.toString(),
      textDirection: TextDirection.ltr,
    );
  }
}

class DependentVmView extends StatelessView<DependentVm> {
  DependentVmView({Key? key}) : super(key: key, reactive: true);

  Widget render(BuildContext context, DependentVm vm) {
    return Text(
      vm.value.toString(),
      textDirection: TextDirection.ltr,
    );
  }
}

/// NonReactive views.

class NonReactiveView extends StatelessView<BaseVm> {
  NonReactiveView({Key? key}) : super(key: key, reactive: false);

  Widget render(BuildContext context, BaseVm vm) {
    return Text(
      vm.counter.toString(),
      textDirection: TextDirection.ltr,
    );
  }
}
