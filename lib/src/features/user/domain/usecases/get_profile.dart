import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetProfile {
  final UserRepository repository;

  GetProfile(this.repository);

  Future<Either<Failure, User>> call() {
    return repository.getProfile();
  }
}