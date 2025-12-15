import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { attendee, organizer }

class User {
  final String id;
  final String name;
  final UserRole role;

  User({required this.id, required this.name, required this.role});
}

class AuthState {
  final User? user;
  AuthState({this.user});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void loginAsAttendee() {
    state = AuthState(user: User(id: 'u_att', name: 'Attendee', role: UserRole.attendee));
  }

  void loginAsOrganizer() {
    state = AuthState(user: User(id: 'u_org', name: 'Organizer', role: UserRole.organizer));
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
