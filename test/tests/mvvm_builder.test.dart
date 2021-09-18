import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmvvm/pmvvm.dart';

import '../setup/view_model.setup.dart';

void main() {
  group('MVVM buidler tests -', () {
    group('implicitView functionality tests -', () {
      testWidgets('When the view is explicit and the implicitView is true Then the view wont listen to the VM changes', (tester) async {
        // ARRANGE
        final viewModel = BaseVm();

        await tester.pumpWidget(
          MVVM<BaseVm>(
            viewModel: viewModel,
            view: (_, vm) {
              return Text(
                vm.counter.toString(),
                textDirection: TextDirection.ltr,
              );
            },
          ),
        );

        // ACT
        viewModel.increase();
        await tester.pump();

        // ASSERT
        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('When the view is explicit and the implicitView is false Then the view listens to the VM changes', (tester) async {
        // ARRANGE
        final viewModel = BaseVm();

        await tester.pumpWidget(
          MVVM<BaseVm>(
            implicitView: false,
            viewModel: viewModel,
            view: (_, vm) {
              return Text(
                vm.counter.toString(),
                textDirection: TextDirection.ltr,
              );
            },
          ),
        );

        // ACT
        viewModel.increase();
        await tester.pump();

        // ASSERT
        expect(find.text('1'), findsOneWidget);
      });
    });
  });
}
