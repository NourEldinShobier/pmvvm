import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';
import 'mvvm-builder.widget.dart';

/// A wrapper widget for the [MVVM] class in a less boilerplate.
abstract class MVVMWidget<T extends ChangeNotifier> extends StatelessWidget {
  const MVVMWidget({Key key}) : super(key: key);

  /// A builder function for the View widget, it also has access
  /// to the viewmodel.

  Widget view(BuildContext context, T model);

  /// A builder function for the viewmodel of the view.
  T viewModel();

  /// To dispose the viewmodel when the provider is removed from the
  /// widget tree.
  ///
  /// default's to [true]
  bool get disposeVM => true;

  /// To rebuid the viewmodel everytime the widget is inserted to widget tree.
  bool get createNewModelOnInsert => false;

  /// Init the viewmodel only once
  bool get initOnce => false;

  @override
  Widget build(BuildContext context) {
    return MVVM<T>(
      view: view,
      viewModel: () => viewModel(),
      disposeVM: disposeVM,
      createNewModelOnInsert: createNewModelOnInsert,
      initOnce: initOnce,
    );
  }
}
