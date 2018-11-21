import 'package:flutter_test/flutter_test.dart';
import 'dart:async';
import 'package:flutter_eventemitter/flutter_eventemitter.dart';

void main() {
  test('EventEmitter: data type', () {
    var message = 'subscribe';

    EventEmitter.subscribe(message, (data) {
      bool isString = data is String;
      bool isInt = data is int;
      bool isBool = data is bool;
      bool isList = data is List;
      bool isMap = data is Map;
      expect(isString || isInt || isBool || isList || isMap, true);
    });

    EventEmitter.publish(message, 'string');
    EventEmitter.publish(message, 1);
    EventEmitter.publish(message, false);
    EventEmitter.publish(message, [1]);
    EventEmitter.publish(message, {1: 2});
  });
 
  test('EventEmitter: async', () {
    var message = 'subscribe';
    List<int> receives = [];

    EventEmitter.subscribe(message, (data) {
      receives.add(data);
      if (receives.length == 2) {
        expect(receives, [1, 2]);
      }
    });

    EventEmitter.publish(message, 2);
    EventEmitter.publishSync(message, 1);
  });
}
