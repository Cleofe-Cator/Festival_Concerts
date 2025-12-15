import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/log_in.dart';
import '../../domain/usecases/log_out.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/update_profile.dart';
import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final GetProfile getProfile;
  final LogIn logIn;
  final LogOut logOut;
  final SignUp signUp;
  final UpdateProfile updateProfile;

  UserNotifier(super._state, {
    required this.getProfile,
    required this.logIn,
    required this.logOut,
    required this.signUp,
    required this.updateProfile,
  });

  // Helper to handle either-style (fold) or direct-return results.
  void _handleResult(
    dynamic result, {
    required void Function(dynamic success) onSuccess,
  }) {
    // treat null as success (usecases that return void / no value)
    if (result == null) {
      onSuccess(null);
      return;
    }

    // direct domain type or list
    if (result is UserState || result is List<UserCredential>) {
      onSuccess(result);
      return;
    }

    // attempt fold for Either-like results, fallback to treating result as success
    try {
      (result as dynamic).fold(
        (failure) => state = state.copyWith(status: UserStatus.failure, errorMessage: failure.toString()),
        (value) => onSuccess(value),
      );
    } catch (_) {
      // fallback: treat result as success value
      try {
        onSuccess(result);
      } catch (e) {
        state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
      }
    }
  }

  Future<void> fetchProfile() async {
    state = state.copyWith(status: UserStatus.loading, errorMessage: null);
    try {
      final result = await getProfile.call();
      _handleResult(result, onSuccess: (user) {
        final userCredential = user as UserCredential?;
        final firebaseUser = userCredential?.user;
        final Map<String, dynamic>? userMap = firebaseUser == null
            ? null
            : {
                'uid': firebaseUser.uid,
                'email': firebaseUser.email,
                'displayName': firebaseUser.displayName,
                'photoURL': firebaseUser.photoURL,
              };
        state = state.copyWith(user: userMap, status: UserStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> signIn() async {
    state = state.copyWith(status: UserStatus.loading, errorMessage: null);
    try {
      final result = logIn;
      _handleResult(result, onSuccess: (user) {
        state = state.copyWith(status: UserStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> signUpUser(() param0) async {
    state = state.copyWith(status: UserStatus.loading, errorMessage: null);
    try {
      final result = signUp;
      _handleResult(result, onSuccess: (user) {
        state = state.copyWith(status: UserStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> update() async {
    state = state.copyWith(status: UserStatus.loading, errorMessage: null);
    try {
      final result = updateProfile;
      _handleResult(result, onSuccess: (updated) {
        state = state.copyWith(status: UserStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(status: UserStatus.loading, errorMessage: null);
    try {
      final result = await logOut.call();
      _handleResult(result, onSuccess: (_) {
        state = state.copyWith(user: null, status: UserStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: UserStatus.failure, errorMessage: e.toString());
    }
  }
}
