# PMVVM
A clean & simple MVVM architecture for state management that uses Provider & Hooks under the hood. The package adopts some concepts from the `stacked` package, but with much simpler & cleaner implementation.

![](https://i.imgur.com/cK19Sm8.png)

# How Does it work ⚙️
3 major pieces are needed, everything else is up to you. These pieces are:

- **View**: It represents the UI of the application devoid of any Application Logic. The `ViewModel` sends notifications to the `view` to update the UI whenever state changes.
- **ViewModel**: It acts as a bridge between the `Model` and the `View`. It’s responsible for transforming the data from the `Model`, it also holds the events of the `View`
- **Model**: Holds app data and the business logic. It consists of the business logic - local and remote data source, model classes, repository. They’re usually simple classes.

### Advantages ✔️

- Your code is even more easily testable.
- Your code is further decoupled (the biggest advantage.)
- The package structure is even easier to navigate.
- The project is even easier to maintain.
- Your team can add new features even more quickly.

### When to use it 👌
To keep it simple, use the `MVVM` whenever your widget has its own events that can mutate the state directly e.g: pages, posts, ..etc.

**Some Notes**
- `View` can't acess the `Model` directly
- `View` is devoid of any application logic
- `ViewModel` has only one `View` whether it was a page, post, ..etc.

# Usage 👨‍💻
Let's look at the code. First We build our `ViewModel`
```dart
class MyViewModel extends ViewModel {
  int counter = 0;

  // Optional
  @override
  void init() {
    // It's called after the ViewModel is constructed
  }

  // Optional
  @override
  void build() {
    // It's called everytime the view is rebuilt
  }

  void increase() {
    counter++;
    notifyListeners();
  }
}
```
Then We build our `View` and the `MVVM` builder
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<MyViewModel>(
      view: (context, vmodel) => const _MyView(),
      viewModel: () => MyViewModel(),
    );
  }
}

class _MyView extends HookView<MyViewModel> {
  /// Set [reactive] to [false] if you don't the view to listen to the ViewModel.
  /// It's [true] by default.
  const _MyView({Key key}) : super(key: key, reactive: true); 

  @override
  Widget render(context, vmodel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(vmodel.counter.toString()),
        SizedBox(height: 24),
        RaisedButton(onPressed: vmodel.increase, child: Text('Increase')),
      ],
    );
  }
}
```
And if We want to use less boilerplate, We can use `MVVMWidget` instead of the builder.
```dart
class _MyView extends MVVMWidget<MyViewModel> {
  const _MyView({Key key}) : super(key: key);

  @override
  Widget view(context, vmodel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(vmodel.counter.toString()),
        SizedBox(height: 24),
        RaisedButton(onPressed: vmodel.increase, child: Text('Increase')),
      ],
    );
  }

  @override
  MyViewModel viewModel() => MyViewModel();
}
```

### More details
- You can call the `init` method only one time, by setting the `initOnce` of the `MVVM` builder or the `MVVMWidget` to `true`
- You can acess the `context` from the `ViewModel` directly
```dart
class MyViewModel extends ViewModel {
  @override
  void init() {
    var height = MediaQuery.of(context).size.height;
  }
}
```

# Dependencies 📦
- `provider`
- `flutter_hooks`

<h3 align='center'>Made with :heart:</h3>