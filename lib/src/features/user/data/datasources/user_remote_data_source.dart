import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });

  Future<UserModel> logIn({
    required String email,
    required String password,
  });

  Future<UserModel> getProfile();

  Future<void> updateProfile({
    required String name,
    required UserRole role,
  });

  Future<void> logOut();
}
