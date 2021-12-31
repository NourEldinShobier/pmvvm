import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';

import 'mvvm_builder.props.dart';

/// The MVVM builder widget.
class MVVM<T extends ViewModel> extends StatefulWidget {
  final MVVMBaseProps<T> props;

  MVVM({
    Key? key,
    required Widget Function() view,
    required T viewModel,
    bool disposeVM = true,
    bool initOnce = false,
  })  : props = MVVMProps(
          view: view,
          viewModel: viewModel,
          disposeVM: disposeVM,
          initOnce: initOnce,
        ),
        super(key: key);

  MVVM.builder({
    Key? key,
    required Widget Function(BuildContext, T) viewBuilder,
    required T viewModel,
    bool disposeVM = true,
    bool initOnce = false,
  })  : props = MVVMBuilderProps(
          viewBuilder: viewBuilder,
          viewModel: viewModel,
          disposeVM: disposeVM,
          initOnce: initOnce,
        ),
        super(key: key);

  @override
  _MVVMState<T> createState() => _MVVMState<T>();
}

class _MVVMState<T extends ViewModel> extends State<MVVM<T>> with WidgetsBindingObserver {
  late T _vm;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    _vm = widget.props.viewModel;

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _vm.onResume();
    } else if (state == AppLifecycleState.inactive) {
      _vm.onInactive();
    } else if (state == AppLifecycleState.paused) {
      _vm.onPause();
    } else if (state == AppLifecycleState.detached) {
      _vm.onDetach();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (identical(_vm, widget.props.viewModel)) {
      _vm = widget.props.viewModel;
    }

    _vm.context = context;

    if (widget.props.initOnce && !_initialised) {
      _vm.init();
      _initialised = true;
    } else if (!widget.props.initOnce) {
      _vm.init();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _vm.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _vm.onBuild();

    if (widget.props is MVVMProps) {
      final props = widget.props as MVVMProps<T>;

      if (!widget.props.disposeVM) {
        return ChangeNotifierProvider<T>.value(value: _vm, child: props.view());
      }

      return ChangeNotifierProvider<T>(create: (_) => _vm, child: props.view());
    }

    final props = widget.props as MVVMBuilderProps<T>;

    if (!widget.props.disposeVM) {
      return ChangeNotifierProvider<T>.value(
        value: _vm,
        child: Consumer<T>(
          builder: (context, vm, _) => props.viewBuilder(context, vm),
        ),
      );
    }

    return ChangeNotifierProvider<T>(
      create: (_) => _vm,
      child: Consumer<T>(
        builder: (context, vm, _) => props.viewBuilder(context, vm),
      ),
    );
  }
}
