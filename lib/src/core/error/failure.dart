import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure([String message = 'Server Failure']) : super(message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure([String message = 'Not Found']) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure([String message = 'Validation Failure']) : super(message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure([String message = 'Unauthorized']) : super(message);
}