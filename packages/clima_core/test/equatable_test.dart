import 'package:clima_core/equatable.dart';
import 'package:test/test.dart';

class _Foo with Equatable<_Foo> {
  _Foo(this.a, this.b, {this.checkRuntimeType = false});

  final String a;

  final int b;

  @override
  final bool checkRuntimeType;

  @override
  List<Object> get props => [a, b];
}

class _Bar extends _Foo {
  _Bar(String a, int b, {bool checkRuntimeType = false})
      : super(
          a,
          b,
          checkRuntimeType: checkRuntimeType,
        );
}

void main() {
  group('Equatable', () {
    // TODO: maybe we should add tests for `hashCode` too.
    group('==', () {
      test('returns true for identical objects', () {
        final obj = _Foo('whatever', 1);
        expect(obj, obj);
      });

      test('returns true when props have same values', () {
        expect(_Foo('bar', 2), _Foo('bar', 2));
        expect(_Foo('baz', 324), _Foo('baz', 324));
      });

      test('returns false when props are different', () {
        expect(_Foo('bar', 3), isNot(_Foo('baz', 3)));
        expect(_Foo('baz', 2), isNot(_Foo('baz', 3)));
      });

      test('returns true when given object is of a different type', () {
        expect(_Foo('bar', 2), isNot('2'));
        expect(_Foo('fad', 2), isNot(3));
      });

      test(
          'returns true when given object is a subtype and checkRuntimeType is false',
          () {
        expect(_Foo('1', 2), _Bar('1', 2));
      });

      test(
          'returns false when given object is subtype and checkRuntimeType is true',
          () {
        expect(
          _Foo('1', 2, checkRuntimeType: true),
          isNot(_Bar('1', 2, checkRuntimeType: true)),
        );
      });
    });
  });
}
