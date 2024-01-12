import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  late final List properties;

  Failure([List properties = const <dynamic>[]]) : this.properties = properties;

  @override
  List<Object?> get props => [properties];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class UnknownFailure extends Failure {
  final String? message;

  UnknownFailure([this.message]) : super([message]);
}

class NetworkFailure extends Failure {
  final String? message;

  NetworkFailure([this.message = "No internet connection"]) : super([message]);
}
