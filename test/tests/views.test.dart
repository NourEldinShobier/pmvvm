import 'package:flutter_test/flutter_test.dart';
import 'package:pmvvm/pmvvm.dart';

import '../setup/view_model.setup.dart';
import '../setup/views.setup.dart';

void main() {
  group('Views tests -', () {
    group('Reactive functionality tests -', () {
      testWidgets('When view is non-reactive Then it wont listen to the VM changes', (tester) async {
        // ARRANGE
        final vm = BaseVm();

        await tester.pumpWidget(
          MVVM(
            viewModel: vm,
            view: (_, __) => NonReactiveView(),
          ),
        );

        // ACT
        vm.increase();
        await tester.pump();

        // ASSERT
        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('When view is reactive Then it will listen to the VM changes', (tester) async {
        // ARRANGE
        final vm = BaseVm();

        await tester.pumpWidget(
          MVVM(
            viewModel: vm,
            view: (_, __) => ReactiveView(),
          ),
        );

        // ACT
        vm.increase();
        await tester.pump();

        // ASSERT
        expect(find.text('1'), findsOneWidget);
      });
    });
  });
}
