import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:pmvvm/pmvvm.dart';
import 'view-model.dart';

class MVVM<T extends ChangeNotifier?> extends StatefulWidget {
  /// A builder function for the View widget, it also has access
  /// to the viewmodel.
  final Widget Function(BuildContext, T) view;

  /// A builder function for the viewmodel of the view.
  final T viewModel;

  /// To dispose the viewmodel when the provider is removed from the
  /// widget tree.

  /// default's to [true]
  final bool disposeVM;

  /// Init the viewmodel only once
  final bool initOnce;

  const MVVM({
    required this.view,
    required this.viewModel,
    this.disposeVM = true,
    this.initOnce = false,
    Key? key,
  }) : super(key: key);

  @override
  _MVVMState<T> createState() => _MVVMState<T>();
}

class _MVVMState<T extends ChangeNotifier?> extends State<MVVM<T?>> {
  T? _vm;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    _vm = widget.viewModel;

    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.resumed.toString()) {
        (_vm as ViewModel).onResume();
      } else if (msg == AppLifecycleState.inactive.toString()) {
        (_vm as ViewModel).onInactive();
      } else if (msg == AppLifecycleState.paused.toString()) {
        (_vm as ViewModel).onPause();
      } else if (msg == AppLifecycleState.detached.toString()) {
        (_vm as ViewModel).onDetach();
      }

      return '';
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (identical(_vm, widget.viewModel)) {
      _vm = widget.viewModel;
    }

    (_vm as ViewModel?)?.context = this.context;

    if (widget.initOnce && !_initialised) {
      (_vm as ViewModel?)?.init();
      _initialised = true;
    } else if (!widget.initOnce) {
      (_vm as ViewModel?)?.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    (_vm as ViewModel?)?.onBuild();

    if (!widget.disposeVM) {
      return ChangeNotifierProvider.value(
        value: _vm,
        child: widget.view(context, _vm),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => _vm,
      child: widget.view(context, _vm),
    );
  }
}
