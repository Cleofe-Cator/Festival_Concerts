import 'package:flutter/foundation.dart';

enum UserStatus { initial, loading, success, failure }

@immutable
class UserState {
  final Map<String, dynamic>? user;
  final List<Map<String, dynamic>> users;
  final UserStatus status;
  final String? errorMessage;

  const UserState({
    this.user,
    this.users = const <Map<String, dynamic>>[],
    this.status = UserStatus.initial,
    this.errorMessage,
  });

  UserState copyWith({
    Map<String, dynamic>? user,
    List<Map<String, dynamic>>? users,
    UserStatus? status,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      users: users ?? this.users,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
