import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server Failure']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Not Found']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation Failure']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized']);
}