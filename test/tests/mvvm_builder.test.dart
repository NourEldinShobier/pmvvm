import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pmvvm/pmvvm.dart';

import '../setup/view_model.setup.dart';

void main() {
  group('MVVM buidler tests -', () {
    group('builderView functionality tests -', () {
      testWidgets('When the VM notifyListeners Then the view listens to the VM changes', (tester) async {
        // ARRANGE
        final viewModel = BaseVm();

        await tester.pumpWidget(
          MVVM<BaseVm>.builder(
            viewModel: viewModel,
            viewBuilder: (_, vm) {
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
