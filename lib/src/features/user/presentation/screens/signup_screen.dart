import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

// --- Mock User State ---
enum UserStatus { initial, success, failure }

class UserState {
  final UserStatus status;
  final Map<String, dynamic>? user;
  final String? errorMessage;

  UserState({this.status = UserStatus.initial, this.user, this.errorMessage});

  UserState copyWith({UserStatus? status, Map<String, dynamic>? user, String? errorMessage}) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// --- Notifier ---
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());

  void signUpUser(Map<String, dynamic> data) {
    // Simple mock logic: accept any signup
    if (data['email'] != null && data['password'] != null) {
      state = UserState(
        status: UserStatus.success,
        user: {
          "name": data['name'],
          "email": data['email'],
          "role": data['role'],
        },
      );
    } else {
      state = UserState(
        status: UserStatus.failure,
        errorMessage: "Missing required fields",
      );
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

// --- SignUp Screen ---
class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();
    final userState = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);

    ref.listen(userProvider, (prev, next) {
      if (next.status == UserStatus.success && next.user != null) {
        if (next.user!['role'] == 'organizer') {
          context.go('/organizer-dashboard');
        } else {
          context.go('/event-discovery');
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormBuilderDropdown<String>(
                name: 'role',
                decoration: const InputDecoration(labelText: 'Sign up as'),
                initialValue: 'attendee',
                items: const [
                  DropdownMenuItem(value: 'attendee', child: Text('Attendee')),
                  DropdownMenuItem(value: 'organizer', child: Text('Organizer')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Name / Organization Name'),
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
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'password',
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final data = formKey.currentState!.value;
                    notifier.signUpUser(data);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Account created successfully!")),
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
              if (userState.status == UserStatus.failure)
                Text(userState.errorMessage ?? '',
                    style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
