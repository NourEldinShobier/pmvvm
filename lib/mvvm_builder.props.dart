import 'package:flutter/widgets.dart';
import 'view_model.dart';

class MVVMBaseProps<T extends ViewModel> {
  /// The view model of the view.
  final T viewModel;

  /// To dispose the [viewModel] when the provider is removed from the
  /// widget tree.
  final bool disposeVM;

  /// Whether the [viewModel] should be initialized once or every time the
  /// the dependencies change.
  final bool initOnce;

  MVVMBaseProps({
    required this.viewModel,
    required this.disposeVM,
    required this.initOnce,
  });
}

class MVVMProps<T extends ViewModel> extends MVVMBaseProps<T> {
  /// A builder function for the View widget.
  final Widget Function() view;

  MVVMProps({
    required this.view,
    required T viewModel,
    required bool disposeVM,
    required bool initOnce,
  }) : super(viewModel: viewModel, disposeVM: disposeVM, initOnce: initOnce);
}

class MVVMBuilderProps<T extends ViewModel> extends MVVMBaseProps<T> {
  /// A builder function for the View widget, it also has access
  /// to the [viewModel].
  final Widget Function(BuildContext, T) viewBuilder;

  MVVMBuilderProps({
    required this.viewBuilder,
    required T viewModel,
    required bool disposeVM,
    required bool initOnce,
  }) : super(viewModel: viewModel, disposeVM: disposeVM, initOnce: initOnce);
}
