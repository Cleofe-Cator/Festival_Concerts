import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// --- Mock User Model ---
class User {
  final String name;
  final String email;
  final String role;
  final String avatarUrl;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
  });
}

// --- Mock User State ---
class UserState {
  final User? user;
  UserState({this.user});
}

// --- Mock Provider (replace with your real provider) ---
final userProvider = Provider<UserState>((ref) {
  return UserState(
    user: User(
      name: "Mae",
      email: "mae@example.com",
      role: "attendee",
      avatarUrl: "https://i.pravatar.cc/150?img=3", // sample avatar
    ),
  );
});

// --- Profile Screen ---
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final user = userState.user;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user found.')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text('Name: ${user.name}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('Email: ${user.email}',
                style: const TextStyle(fontSize: 16)),
            Text('Role: ${user.role}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/edit-profile'),
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
