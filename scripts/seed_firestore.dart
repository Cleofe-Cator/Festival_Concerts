import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fc_app/firebase_options.dart';

/// Seeds Firestore collections using `scripts/initial_data.json`.
///
/// Initialize Firebase with `DefaultFirebaseOptions.currentPlatform`.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    print('Firebase initialized (Firestore seeder).');
  }

  final firestore = FirebaseFirestore.instance;

  final file = File('${Directory.current.path.replaceAll('\\', '/')}/scripts/initial_data.json');
  if (!await file.exists()) {
    if (kDebugMode) {
      print('initial_data.json not found at scripts/initial_data.json');
    }
    return;
  }

  final raw = await file.readAsString();
  final Map<String, dynamic> data = jsonDecode(raw);

  for (final collectionName in data.keys) {
    final docs = data[collectionName] as List<dynamic>;
    if (kDebugMode) {
      print('Seeding collection: $collectionName (${docs.length} docs)');
    }
    for (final doc in docs) {
      if (doc is! Map) continue;
      final map = Map<String, dynamic>.from(doc);
      final id = map.remove('id');
      final docRef = (id != null)
          ? firestore.collection(collectionName).doc(id.toString())
          : firestore.collection(collectionName).doc();
      await docRef.set(map);
      if (kDebugMode) {
        print('  - wrote $collectionName/${docRef.id}');
      }
    }
  }

  if (kDebugMode) {
    print('Firestore seeding finished.');
  }
}
