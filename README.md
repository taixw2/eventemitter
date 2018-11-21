# eventemitter

Dependency free publish/subscribe(pub/sub) for dart&flutter.

## How to use

Open the `pubspec.yaml` file, and add `eventemitter:` unde dependencies:
``` yaml
  dependencies:
    flutter:
      sdk: flutter
    # ...
    # ...
    eventemitter: ^0.1.3
```    
install it from terminal: `Run flutter packages get`

## Example
- [](./example/main.dart)
- [](./test/eventemitter_test.dart)

``` dart
String token = EventEmitter.subscribe('topic', (data) {
  // receive 2
  print(data);
});

EventEmitter.publish('topic', 1)
EventEmitter.publishSync('topic', 2)
EventEmitter.unsubscribe(token);

```

## Link
- [https://github.com/mroderick/PubSubJS](https://github.com/mroderick/PubSubJS)
- [https://gist.github.com/juliangruber/3160726](https://gist.github.com/juliangruber/3160726)
- [https://github.com/primus/eventemitter3](https://github.com/primus/eventemitter3)
