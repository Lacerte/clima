import 'package:collection/collection.dart';

/// A mixin to help decrease the boilerplate associated with [==] and
/// [hashCode].
///
/// [T] should be the current class.
///
/// Example usage:
/// ```dart
/// class A with Equatable<A> {
///   const A(this.b);
///
///   final int b;
///
///   @override
///   List<Object> get props => [b];
/// }
/// ```
mixin Equatable<T extends Equatable<T>> {
  List<Object> get props;

  bool get checkRuntimeType;

  static const _propsEquality = ListEquality(DeepCollectionEquality());

  @override
  bool operator ==(Object that) =>
      identical(this, that) ||
      (that is T &&
          (!checkRuntimeType || runtimeType == that.runtimeType) &&
          _propsEquality.equals(props, that.props));

  @override
  int get hashCode => props.fold(
        checkRuntimeType ? runtimeType.hashCode : 0,
        (a, b) => a ^ b.hashCode,
      );
}
