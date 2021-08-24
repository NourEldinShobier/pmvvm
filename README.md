<p align="center">
  <img height="400" src="https://i.imgur.com/5Ve6Sxi.png">
</p>

PMVVM is a Flutter package for simple and scalable state management based on the MVVM pattern, it uses Provider & Hooks under the hood. PMVVM serves the same purpose BloC, but unlike BloC it doesn’t require too much boilerplate.

It's worth mentioning that the package adopts some concepts from the Stacked package, but with a much simpler and cleaner approach.

# How does it work ⚙️

Three major pieces are needed, everything else is up to you. These pieces are:

### **View**

It represents the UI of the application devoid of any application logic. The view model sends notifications to the view to update the UI whenever the state changes.

### **ViewModel**

Which holds the state and the events of the view. Additionally, It acts as a bridge between the model and the view.

The view model is platform-independent and doesn't know its view. Therefore, it can be easily bound to a web, mobile, or desktop view.

### **Model**

Holds app data and the business logic. It consists of the business logic (e.g. local and remote data sources, model classes, and repositories). They’re usually simple classes.

**When should you use PMVVM?** 👌

To keep it simple, use it whenever your widget has its own events that can mutate the state directly e.g: pages, posts, ...etc.

# Usage 👨‍💻

The best way to get to know PMVVM is to get your hands dirty and try it out. Let's look at the code:

- Build your `ViewModel`.

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

- You can also access the `context` inside the `ViewModel` directly.

```dart
class MyViewModel extends ViewModel {
  @override
  void init() {
    var height = MediaQuery.of(context).size.height;
  }
}
```

- Declare `MVVM` inside your builder.

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

- Build your `View`.

```dart
// StatelessView

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
```

# More about PMVVM🎯

- The `init` lifecycle method is called by default every time the view model dependencies are updated. To init the `ViewModel` only once and ignore dependencies updates, set `initOnce` of the `MVVM` builder to `true`.
- You can use `context.fetch<T>(listen: true/false)` which is equivalent to `Provider.of<T>(context)`
- To make the view ignore the state notifications from the `ViewModel` , set `reactive` to `false` when you are constructing the `StatelessView` or `HookView` :

```dart
class _MyView extends StatelessView<MyViewModel> {
  const _MyView({Key key}) : super(key: key, reactive: false);
  ....
}
```

- `ViewModel` Lifecycle methods **(All of them are optional)**

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

# Patterns 🧩

In this section Let's discuss some patterns that can help your view model to access your widget properties:

- **Naive approach:** Using cascade notation to initialize your view model with the widget properties. The problem with this approach is that your view model becomes non-reactive when the widget's dependencies (properties) are updated.

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

- **Clean approach:** similar to ReactJS, you should create a properties class, in which all your widget properties are kept.

`my_widget.props.dart`

```dart
class MyWidgetProps {
  MyWidgetProps({required this.name});

  final String name;
}
```

`my_widget.vm.dart`

```dart
class MyWidgetVM extends ViewModel {
  late MyWidgetProps props;

  @override
  void init() {
    props = context.fetch<MyWidgetProps>();
  }
}
```

`my_widget.view.dart`

```dart
class MyWidget extends StatelessWidget {
  MyWidget({
    Key? key,
    required String name,
  })  : props = MyWidgetProps(name: name),
        super(key: key);

  final MyWidgetProps props;

  Widget build(context) {
    return Provider.value(
      value: props,
      child: MVVM<MyWidgetVM>(
        view: (_, __) => _MyWidgetView(),
        viewModel: MyWidgetVM(),
      ),
    );
  }
}
```

# FAQ 🤔

- Can I use it in production?
  - Yep! It's stable and ready to rock
- What is the difference between `Stacked` & `PMVVM` since both adopt the same principles?

| **Stacked**                                                                                                                                                               | **PMVVM**                                                                                                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| You can't access the `BuildContext` from the `ViewModel`.                                                                                                                 | `BuildContext` can be accessed inside the `ViewModel` using:<br />- `Provider.of<T>(context)` <br />- `context.watch<T>()` <br />- `context.read<T>()` <br />- `context.select<T, R>(R cb(T value))`             |
| You should implement the `Initialisable` interface to call `initialise`.                                                                                                  | `init` event is called by default, all you need to do is to override it (optional).                                                                                                                              |
| There is no `build` method in the `ViewModel`.                                                                                                                            | `onBuild` method is called by default every time the `View` is rebuilt, and you can override it to implement yours (optional).                                                                                   |
| It over-wraps `provider` with many `ViewModels` like `FutureViewModel`, `StreamViewModel`, …etc. Which `provider` & `flutter_hooks` are built to do without any wrapping. | It doesn’t over-wrap `provider` package with such classes. Instead, you can use `StreamProvider/FutureProvider` or `Hooks` which gives you the flexibility to make the most out of `provider` & `flutter_hooks`. |
| It has **reactive & non-reactive** constructors that force developers to use consumers in a specific position in the sub-tree.                                            | It doesn’t have such concepts, all you need is to declare the `MVVM` and consume it from anywhere in the sub-tree.                                                                                               |

In summary, PMVVM is simpler & cleaner, there is no over-wrapping, and idioms are more clear.

# Dependencies 📦

- `provider`
- `flutter_hooks`

<h3 align='center'>Made with :heart:</h3>
