import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart' show FormBuilderValidators;
import 'package:go_router/go_router.dart';

// Dummy user model
class User {
  String name;
  String email;
  User({required this.name, required this.email});
}

// Riverpod StateNotifier for user
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(User(name: "Mae", email: "mae@example.com"));

  void update(String name, String email) {
    state = User(name: name, email: email);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);
    final formKey = GlobalKey<FormBuilderState>();

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user found.')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          initialValue: {
            'name': user.name,
            'email': user.email,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final values = formKey.currentState!.value;
                    notifier.update(values['name'], values['email']);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated!")),
                    );

                    context.pop(); // go back after saving
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
