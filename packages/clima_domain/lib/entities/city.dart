import 'package:equatable/equatable.dart';

class ApiKey extends Equatable {
  const ApiKey({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}
