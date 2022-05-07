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
  });
}
