import 'package:monkey_lang/object/object.dart';
import 'package:test/test.dart';

void main() {
  test('test string hashkey', () {
    var hello1 = MonkeyString('Hello World');
    var hello2 = MonkeyString('Hello World');
    var diff1 = MonkeyString('My name is johnny');
    var diff2 = MonkeyString('My name is johnny');
    expect(hello1.hashKey(), equals(hello2.hashKey()));
    expect(diff1.hashKey(), equals(diff2.hashKey()));
    expect(hello1.hashKey(), isNot(equals(diff1.hashKey())));
  });

  test('test boolean hashkey', () {
    var true1 = MonkeyBoolean(true);
    var true2 = MonkeyBoolean(true);
    var false1 = MonkeyBoolean(false);
    var false2 = MonkeyBoolean(false);
    expect(true1.hashKey(), equals(true2.hashKey()));
    expect(false1.hashKey(), equals(false2.hashKey()));
    expect(true1.hashKey(), isNot(equals(false1.hashKey())));
  });

  test('test integer hashkey', () {
    var one1 = MonkeyInteger(1);
    var one2 = MonkeyInteger(1);
    var two1 = MonkeyInteger(2);
    var two2 = MonkeyInteger(2);
    expect(one1.hashKey(), equals(one2.hashKey()));
    expect(two1.hashKey(), equals(two2.hashKey()));
    expect(one1.hashKey(), isNot(equals(two1.hashKey())));
  });
}
