import 'package:pvt_23/counter.dart';
import 'package:test/test.dart';

void main() {
  group('Counter', () {
    test('value should start at0', (){
      expect(Counter().value, 0);
    });
    test('value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
    test('value should be decremented', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}
