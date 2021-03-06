<p align="center">
  <img height="400" src="https://i.imgur.com/5Ve6Sxi.png">
</p>

<p align="center">
  A clean & simple MVVM architecture for state management that uses Provider & Hooks under the hood. This package adopts some concepts from Stacked package, but with much simpler & cleaner approach.
</p>

# How does it work ⚙️

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

- `View` can't access the `Model` directly
- `View` is devoid of any application logic
- `ViewModel` has only one `View` whether it was a page, post, ..etc.

# Usage 👨‍💻

Let's look at the code:

**1.** Build your `ViewModel`.

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
  void onBuild() {
    // It's called everytime the view is rebuilt
  }

  void increase() {
    counter++;
    notifyListeners();
  }
}
```

You can also access the `context` inside the `ViewModel` directly

```dart
class MyViewModel extends ViewModel {
  @override
  void init() {
    var height = MediaQuery.of(context).size.height;
  }
}
```

**2.** Declare `MVVM` inside your widget.

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MVVM<MyViewModel>(
      view: (context, vmodel) => _MyView(),
      viewModel: MyViewModel(),
    );
  }
}
```

**3.** Build your `View`.

```dart
// HookView

class _MyView extends HookView<MyViewModel> {
  /// Set [reactive] to [false] if you don't want the view to listen to the ViewModel.
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

// OR: StatelessView

class _MyView extends StatelessView<MyViewModel> {
  /// Set [reactive] to [false] if you don't want the view to listen to the ViewModel.
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
```

# More details

`ViewModel` Events **(All of them are optional)**

```dart
  /// - Event callback after [ViewModel] is constructed.
  /// - The event is called by default every time the [ViewModel] view dependencies are updated.
  /// - Set [initOnce] of the [MVVM] as [true] to ignore dependencies updates.
  void init() {}

  /// Event callback when the [build] method is called.
  void onBuild() {}

  /// Event callback when the view disposed.
  void onDispose() {}

  /// Event callback when the application is visible and responding to user input.
  void onResume() {}

  /// Event callback when the application is not currently visible to the user, not responding to
  /// user input, and running in the background.
  void onPause() {}

  /// - Event callback when the application is in an inactive state and is not receiving user input.
  /// - For [IOS] only.
  void onInactive() {}

  /// - Event callback when the application is still hosted on a flutter engine but
  ///   is detached from any host views.
  /// - For [Android] only.
  void onDetach() {}
```

# Patterns

#### How to pass widget parameters to the `ViewModel`

- **Option(1):** using `Cascade notation` - Easy Solution -

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key key, this.varName}) : super(key: key);

  final String varName;

  @override
  Widget build(BuildContext context) {
    return MVVM<MyViewModel>(
      view: (context, vmodel) => _MyView(),
      viewModel: MyViewModel()..varName = varName,
    );
  }
}
```

- **Option(2):** using providers - Clean Solution -

```dart
class MyWidget extends StatelessWidget {
  const MyWidget({Key key, this.varName}) : super(key: key);

  final String varName;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: varName),
      ],
      child: MVVM<MyViewModel>(
        view: (context, vmodel) => _MyView(),
        viewModel: MyViewModel(),
      ),
    );
  }
}
```

```dart
class MyViewModel extends ViewModel {
  @override
  void init() {
    var varName = context.fetch<String>();
  }
}
```

# Notes 🎯

- `init` event after `ViewModel` is constructed.
  - The event is called by default every time the `ViewModel` view dependencies are updated.
  - Set `initOnce` of the `MVVM` as `true` to ignore dependencies updates.
- You can use `context.fetch<T>()` which is equivalent to `Provider.of<T>(context)`
- `example` project contains counter & firebase 2 factor authentication
- For VS Code snippets, visit this [link](https://gist.github.com/NourEldinShobier/d0fd014d737ac1776f5f0daadedcc5af)

# FAQ 🤔

- Can I use it in production?
  - Yep! It's stable and ready to rock
- What is the difference between `Stacked` & `P.MVVM` since both adopts the same principles?

| **Stacked**                                                                                                                                                               | **P.MVVM**                                                                                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| You can't access the `BuildContext` from the `ViewModel`.                                                                                                                 | `BuildContext` can be accessed inside the `ViewModel` using:<br><br>1. `Provider.of<T>(context)`<br>2. `context.watch<T>()`<br>3. `context.read<T>()`<br>4. `context.select<T, R>(R cb(T value))`                 |
| You should implement the `Initialisable` interface to call `initialise`.                                                                                                  | `init` event is called by default, all you need to do is to override it **(optional)**.                                                                                                                           |
| There is no `build` method in the `ViewModel`.                                                                                                                            | `build` method is called by default every time the `View` is rebuilt, and you can override it to implement yours **(optional)**.                                                                                  |
| It over-wraps `provider` with many `ViewModels` like `FutureViewModel`, `StreamViewModel`, …etc. Which `provider` & `flutter_hooks` are built to do without any wrapping. | It doesn’t over-wrap `provider` package with such classes. Instead, you can use `StreamProvider/FutureProvider` or `Hooks` which gives you the flexibility to make the most out of  `provider` & `flutter_hooks`. |
| It has **reactive & non-reactive** constructors that force developers to use consumer in a specific position in the sub-tree.                                             | It doesn’t have such concepts, all you need is to declare the `MVVM` and consume it from anywhere in the sub-tree.                                                                                                |

In summary, P.MVVM is simpler & cleaner, there is no over-wrapping, and idioms are more clear.

# Dependencies 📦

- `provider`
- `flutter_hooks`

<h3 align='center'>Made with :heart:</h3>
