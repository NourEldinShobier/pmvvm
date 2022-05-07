import 'package:flutter/widgets.dart';
import 'view_model.dart';

class MVVMBaseProps<T extends ViewModel> {
  /// The view model of the view.
  final T viewModel;

  /// To dispose the [viewModel] when the provider is removed from the
  /// widget tree.
  final bool disposeVM;

  MVVMBaseProps({
    required this.viewModel,
    required this.disposeVM,
  });
}

class MVVMProps<T extends ViewModel> extends MVVMBaseProps<T> {
  /// A builder function for the View widget.
  final Widget Function() view;

  MVVMProps({
    required this.view,
    required T viewModel,
    required bool disposeVM,
  }) : super(viewModel: viewModel, disposeVM: disposeVM);
}

class MVVMBuilderProps<T extends ViewModel> extends MVVMBaseProps<T> {
  /// A builder function for the View widget, it also has access
  /// to the [viewModel].
  final Widget Function(BuildContext, T) viewBuilder;

  MVVMBuilderProps({
    required this.viewBuilder,
    required T viewModel,
    required bool disposeVM,
  }) : super(viewModel: viewModel, disposeVM: disposeVM);
}
