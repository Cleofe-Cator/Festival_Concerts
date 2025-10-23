import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateProfile {
  final UserRepository repository;

  UpdateProfile(this.repository);

  Future<Either<Failure, void>> call({
    required String name,
    required UserRole role,
  }) {
    return repository.updateProfile(
      name: name,
      role: role,
    );
  }
}