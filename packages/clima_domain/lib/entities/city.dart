import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}
