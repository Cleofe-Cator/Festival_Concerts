import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      id: userCredential.user!.uid,
      email: email,
      name: name,
      role: role,
    );

    await firestore.collection('users').doc(user.id).set(user.toMap());
    return user;
  }

  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final doc =
        await firestore.collection('users').doc(userCredential.user!.uid).get();
    return UserModel.fromDocument(doc);
  }

  @override
  Future<UserModel> getProfile() async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('No user logged in');

    final doc = await firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromDocument(doc);
  }

  @override
  Future<void> updateProfile({
    required String name,
    required UserRole role,
  }) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) throw Exception('No user logged in');

    await firestore.collection('users').doc(currentUser.uid).update({
      'name': name,
      'role': role.name,
    });
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
}
