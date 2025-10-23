import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class LogIn {
  final UserRepository repository;

  LogIn(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return repository.logIn(
      email: email,
      password: password,
    );
  }
}