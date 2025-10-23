import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      final user = await remoteDataSource.signUp(
        email: email,
        password: password,
        name: name,
        role: role,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.logIn(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    try {
      final user = await remoteDataSource.getProfile();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    required String name,
    required UserRole role,
  }) async {
    try {
      await remoteDataSource.updateProfile(name: name, role: role);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await remoteDataSource.logOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
