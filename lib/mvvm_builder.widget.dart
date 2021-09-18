import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';
import 'view_model.dart';

/// The MVVM builder widget.
class MVVM<T extends ViewModel> extends StatefulWidget {
  /// A builder function for the View widget, it also has access
  /// to the [viewModel].
  final Widget Function(BuildContext, T) view;

  /// The view model of the view.
  final T viewModel;

  /// To dispose the [viewModel] when the provider is removed from the
  /// widget tree.
  final bool disposeVM;

  /// Whether the [viewModel] should be initialized once or every time the
  /// the dependencies change.
  final bool initOnce;

  /// Whether the [view] builder is returning a predefined widget
  /// class - implicit view - (e.g. [StatelessView], [HookView], [StatefulWidget],
  /// and [StatelessWidget]) or returning a dynamic widget.
  ///
  /// When the [implicitView] is `true`, then the view widget is wrapped with
  /// a [Consumer] widget to make it reactive to the view model changes.
  final bool implicitView;

  const MVVM({
    Key? key,
    required this.view,
    required this.viewModel,
    this.disposeVM = true,
    this.implicitView = true,
    this.initOnce = false,
  }) : super(key: key);

  @override
  _MVVMState<T> createState() => _MVVMState<T>();
}

class _MVVMState<T extends ViewModel> extends State<MVVM<T>> with WidgetsBindingObserver {
  late T _vm;
  bool _initialised = false;

  @override
  void initState() {
    super.initState();
    _vm = widget.viewModel;

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
    if (identical(_vm, widget.viewModel)) {
      _vm = widget.viewModel;
    }

    _vm.context = context;

    if (widget.initOnce && !_initialised) {
      _vm.init();
      _initialised = true;
    } else if (!widget.initOnce) {
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

    if (widget.implicitView) {
      if (!widget.disposeVM) {
        return ChangeNotifierProvider<T>.value(value: _vm, child: widget.view(context, _vm));
      }

      return ChangeNotifierProvider<T>(create: (_) => _vm, child: widget.view(context, _vm));
    }

    if (!widget.disposeVM) {
      return ChangeNotifierProvider<T>.value(
        value: _vm,
        child: Consumer<T>(
          builder: (context, vm, _) => widget.view(context, vm),
        ),
      );
    }

    return ChangeNotifierProvider<T>(
      create: (_) => _vm,
      child: Consumer<T>(
        builder: (context, vm, _) => widget.view(context, vm),
      ),
    );
  }
}
