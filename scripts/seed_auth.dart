import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fc_app/firebase_options.dart';

/// Creates Firebase Authentication users from `scripts/initial_data.json`.
/// Uses email/password accounts when `email` and `password` fields are present.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('Firebase initialized (Auth seeder).');
  }

  final auth = FirebaseAuth.instance;

  final file = File('${Directory.current.path.replaceAll('\\', '/')}/scripts/initial_data.json');
  if (!await file.exists()) {
    if (kDebugMode) {
      print('initial_data.json not found at scripts/initial_data.json');
    }
    return;
  }

  final raw = await file.readAsString();
  final Map<String, dynamic> data = jsonDecode(raw);
  final users = (data['users'] as List<dynamic>?) ?? [];

  for (final u in users) {
    if (u is! Map) continue;
    final map = Map<String, dynamic>.from(u);
    final email = map['email'] as String?;
    final password = map['password'] as String?;
    final id = map['id'] as String?;

    if (email == null || password == null) {
      if (kDebugMode) {
        print ('Skipping user (missing email/password): $map');
      }
      continue;
    }

    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Optionally update display name

      final user = userCredential.user;
      if (user != null && map['name'] != null) {
        await user.updateDisplayName(map['name'].toString());
      }
      // If a desired id was provided, note that client SDK cannot change uid.
      if (id != null && id != user?.uid) {
        if (kDebugMode) {
          print('Note: desired id $id differs from created uid ${user?.uid}.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to create user $email: $e');
      }
    }
  }

  if (kDebugMode) {
    print('Auth seeding finished.');
  }
}
