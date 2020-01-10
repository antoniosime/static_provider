# static_provider

Flutter state management package.

## Usage 


<hr>

### Extend StaticChangeNotifier class

```Dart
class CountStaticProvider extends StaticChangeNotifier {
  int count = 0;

  add() {
    count++;
    notifyListeners();
  }

  remove() {
    count--;
    notifyListeners();
  }
}
```


### Create new instance 

```Dart
StaticProvider.addProvider(CountStaticProvider());
```

### Get the instance

```Dart
CountStaticProvider provider = StaticProvider.of<CountStaticProvider>(context);
```

### Example 

```Dart
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    StaticProvider.addProvider(CountStaticProvider());
  }

  @override
  void dispose() {
    StaticProvider.disposeListeners<CountStaticProvider>(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CountStaticProvider provider =
        StaticProvider.of<CountStaticProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${provider.count}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.add(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}

```