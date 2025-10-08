import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class SignUp {
  final UserRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) {
    return repository.signUp(
      email: email,
      password: password,
      name: name,
      role: role,
    );
  }
}