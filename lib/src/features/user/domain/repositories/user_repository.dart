import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });

  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> getProfile();

  Future<Either<Failure, void>> updateProfile({
    required String name,
    required UserRole role,
  });

  Future<Either<Failure, void>> logOut();
}