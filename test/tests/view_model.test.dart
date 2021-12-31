import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmvvm/pmvvm.dart';

import '../setup/view_model.setup.dart';
import '../setup/views.setup.dart';

void main() {
  group('ViewModels tests -', () {
    group('Base tests -', () {
      testWidgets('When notifyListeners is called Then update the listening children', (tester) async {
        // ARRANGE
        final vm = BaseVm();

        await tester.pumpWidget(MVVM(viewModel: vm, view: () => ReactiveView()));

        // ACT
        vm.increase();
        await tester.pump();

        // ASSERT
        expect(find.text('1'), findsOneWidget);
      });
    });

    group('initOnce functionality tests -', () {
      testWidgets('When initOnce is true Then ViewModel init method will be called once', (tester) async {
        // ARRANGE
        final vm = DependentVm();
        final notifier = ValueNotifier<int>(0);

        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: notifier,
            child: MVVM(
              viewModel: vm,
              view: () => DependentVmView(),
              initOnce: true,
            ),
          ),
        );

        // ACT
        notifier.value++;
        await tester.pump();

        // ASSERT
        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('When initOnce is false Then ViewModel init method will be called when dependencies change',
          (tester) async {
        // ARRANGE
        final vm = DependentVm();
        final notifier = ValueNotifier<int>(0);

        await tester.pumpWidget(
          ChangeNotifierProvider.value(
            value: notifier,
            child: MVVM(viewModel: vm, view: () => DependentVmView()),
          ),
        );

        // ACT
        notifier.value++;
        await tester.pump();

        // ASSERT
        expect(find.text('1'), findsOneWidget);
      });
    });
  });
}
