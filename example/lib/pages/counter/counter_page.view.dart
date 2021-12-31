import 'package:pmvvm/pmvvm.dart';
import 'package:flutter/material.dart';

import 'counter_page.vm.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: () => _CounterPageView(),
      viewModel: CounterPageVM(),
    );
  }
}

class _CounterPageView extends StatelessView<CounterPageVM> {
  const _CounterPageView({Key? key}) : super(key: key);

  @override
  Widget render(context, page) {
    return Scaffold(
      appBar: AppBar(title: Text(page.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // If you don't want the viewModel to refresh the whole page, you
            // can set super(key: key, reactive: false) and use the Selector

            /* Selector<CounterPageVM, int>(
              selector: (_, page) => page.counter,
              builder: (_, data, __) {
                return Text(
                  data.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ), */

            Text(
              page.counter.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: page.increase,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
