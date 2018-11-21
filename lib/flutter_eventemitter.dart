library eventemitter;

import 'dart:async';

typedef _Callback<T> = void Function(T);

Map<String, Map<String, _Callback>> messages = {};
Map<String, List<String>> onceTokens = {};
int lastUid = -1;

class EventEmitter {
  static final version = '0.1.0';

  static _deliver(message, data) {
    if (!messages.containsKey(message)) {
      return;
    }

    messages[message].forEach((token, subscriber) {
      subscriber(data);
    });

    // unsubscirbe once token
    if (onceTokens.containsKey(message)) {
      onceTokens[message].forEach((token) {
        EventEmitter.unsubscribe(token);
      });
      onceTokens.remove(message);
    }
  }

  static publish(message, data) {
    Future.microtask(() {
      _deliver(message, data);
    });
  }
  static publishSync(message, data) {
    _deliver(message, data);
  }

  static String subscribe(String message, _Callback cb) {
    String token = '_token${++lastUid}';

    // if message non exist, add message key to messages;
    messages.putIfAbsent(message, () => {})[token] = cb;
    return token;
  }

  static subscribeOnce(String message, _Callback cb) {
    String token = EventEmitter.subscribe(message, cb);
    // Throw: Concurrent modification
    // -----------------------
    // token = EventEmitter.subscribe(message, (data) {
    //   cb(data);
    //   EventEmitter.unsubscribe(token);
    // });

    onceTokens.putIfAbsent(message, () => []).add(token);
  }

  static unsubscribe(value) {
    bool isTopic = value is String && messages.containsKey(value);
    bool isToken = !isTopic && value is String;
    bool isFunction = value is Function;

    if (isTopic) {
      EventEmitter.clear(value);
      return;
    }

    if (isFunction && !messages.containsValue(value)) {
      print('[warn]: unable unsubscribe, no found subscribe: $value');
      return;
    }

    messages.forEach((_, message) {
      if (isToken) {
        message.remove(value);
      }

      if (isFunction) {
        message.removeWhere((_, fn) => fn == value);
      }
    });
  }

  static clear(String topic) {
    messages.remove(topic);
  }

  static clearAll() {
    messages.clear();
  }
}
