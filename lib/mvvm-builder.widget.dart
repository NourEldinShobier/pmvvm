import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'view-model.dart';

class MVVM<T extends ChangeNotifier> extends StatefulWidget {
  /// A builder function for the View widget, it also has access
  /// to the viewmodel.
  final Widget Function(BuildContext, T) view;

  /// A builder function for the viewmodel of the view.
  final T Function() viewModel;

  /// To dispose the viewmodel when the provider is removed from the
  /// widget tree.
  ///
  /// default's to [true]
  final bool disposeVM;

  /// To rebuid the viewmodel everytime the widget is inserted to widget tree.
  final bool createNewModelOnInsert;

  /// Init the viewmodel only once
  final bool initOnce;

  const MVVM({
    @required this.view,
    @required this.viewModel,
    this.disposeVM = true,
    this.createNewModelOnInsert = false,
    this.initOnce = false,
    Key key,
  }) : super(key: key);

  @override
  _MVVMState<T> createState() => _MVVMState<T>();
}

class _MVVMState<T extends ChangeNotifier> extends State<MVVM<T>> {
  T vm;

  @override
  void initState() {
    super.initState();
    // build the viewmodel if it hasn't been built yet.
    if (vm == null) {
      _createViewModel();
    }

    // Or build a new viewmodel whenever [initState] is called.
    else if (widget.createNewModelOnInsert) {
      _createViewModel();
    }
  }

  @override
  void didChangeDependencies() {
    (vm as ViewModel)?.context = this.context;

    if (widget.initOnce && !(vm as ViewModel).initialized) {
      (vm as ViewModel)?.init();
      (vm as ViewModel)?.setInit = true;
    } else if (!widget.initOnce) {
      (vm as ViewModel)?.init();
    }

    super.didChangeDependencies();
  }

  void _createViewModel() {
    if (widget.viewModel != null) {
      vm = widget.viewModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    (vm as ViewModel)?.build();

    if (!widget.disposeVM) {
      return ChangeNotifierProvider.value(
        value: vm,
        child: widget.view(context, vm),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => vm,
      child: widget.view(context, vm),
    );
  }
}
