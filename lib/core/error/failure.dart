import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});
}

// General Failures
class ServerFailure extends Failure {
  @override
  final String? message;

  const ServerFailure({this.message});

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  final String? message;

  const CacheFailure({this.message});

  @override
  List<Object?> get props => [message];
}

class InternetFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ApiFailure extends Failure {
  @override
  final String message;
  const ApiFailure({required this.message});
  @override
  List<Object?> get props => [];
}

class FirbaseMyFailure extends Failure {
  @override
  final String message;

  const FirbaseMyFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class DatabaseFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NormalFailure extends Failure {
  @override
  final String message;

  const NormalFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class ValidationFailure extends Failure {
  @override
  final String message;

  const ValidationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
