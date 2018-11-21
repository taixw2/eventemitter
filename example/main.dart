import 'package:eventemitter/eventemitter.dart';

void main() {
  const MESSAGE = '___message__';

  EventEmitter.subscribe(MESSAGE, (data) {
    // will receive 1 and 2
    // todo: something
  });

  EventEmitter.subscribeOnce(MESSAGE, (data) {
    // will receive 1
    // todo: something
  });

  EventEmitter.publishSync(MESSAGE, 1);
  EventEmitter.publishSync(MESSAGE, 2);

  // remove subscriber
  EventEmitter.clear(MESSAGE);

  subscriber(data) {}

  String token = EventEmitter.subscribe(MESSAGE, subscriber);
  EventEmitter.unsubscribe(token);
  EventEmitter.unsubscribe(subscriber);
}
