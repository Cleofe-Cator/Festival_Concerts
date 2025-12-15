import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import '../data/datasources/user_remote_data_source_impl.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/usecases/get_profile.dart';
import '../domain/usecases/log_in.dart';
import '../domain/usecases/log_out.dart';
import '../domain/usecases/sign_up.dart';
import '../domain/usecases/update_profile.dart';
import 'state/user_notifier.dart';
import 'state/user_state.dart';

class Provider {
  Provider._(); // private

  // Firebase instance provider
  static final firebaseFirestoreProvider =
      riverpod.Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
  // Remote data source provider
  static final userRemoteDataSourceProvider =
      riverpod.Provider((ref) {
    return UserRemoteDataSourceImpl(firebaseAuth: FirebaseAuth.instance, firestore: ref.read(firebaseFirestoreProvider));
  });

  // Repository provider
  static final userRepositoryProvider = riverpod.Provider<UserRepositoryImpl>((ref) {
    final remote = ref.read(userRemoteDataSourceProvider);
    return UserRepositoryImpl(remoteDataSource: remote);
  });

  // Domain use case providers
  static final getProfileProvider = riverpod.Provider<GetProfile>((ref) {
    final repo = ref.read(userRepositoryProvider);
    return GetProfile(repo);
  });

  static final logInProvider = riverpod.Provider<LogIn>((ref) {
    final repo = ref.read(userRepositoryProvider);
    return LogIn(repo);
  });

  static final logOutProvider = riverpod.Provider<LogOut>((ref) {
    final repo = ref.read(userRepositoryProvider);
    return LogOut(repo);
  });

  static final signUpProvider = riverpod.Provider<SignUp>((ref) {
    final repo = ref.read(userRepositoryProvider);
    return SignUp(repo);
  });

  static final updateProfileProvider = riverpod.Provider<UpdateProfile>((ref) {
    final repo = ref.read(userRepositoryProvider);
    return UpdateProfile(repo);
  });

  // StateNotifier provider that exposes UserState
  static final userNotifierProvider =
      riverpod.StateNotifierProvider<UserNotifier, UserState>((ref) {
    return UserNotifier(
      ref as UserState, // Pass the required positional argument (usually a Ref or ProviderReference)
      getProfile: ref.read(getProfileProvider),
      logIn: ref.read(logInProvider),
      logOut: ref.read(logOutProvider),
      signUp: ref.read(signUpProvider),
      updateProfile: ref.read(updateProfileProvider),
    );
  });
}
