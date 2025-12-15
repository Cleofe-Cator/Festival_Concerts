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

  void signIn(String email, String password) {
    // Simple mock logic
    if (email == "reina@gmail.com" && password == "g12345") {
      state = UserState(
        status: UserStatus.success,
        user: {"role": "organizer", "email": email},
      );
    } else if (email == "maeann@gmail.com" && password == "cobre28") {
      state = UserState(
        status: UserStatus.success,
        user: {"role": "attendee", "email": email},
      );
    } else {
      state = UserState(
        status: UserStatus.failure,
        errorMessage: "Invalid credentials",
      );
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

// --- Login Screen ---
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          child: Column(
            children: [
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
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.saveAndValidate() ?? false) {
                    final values = formKey.currentState!.value;
                    notifier.signIn(values['email'], values['password']);
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () => context.go('/signup'),
                child: const Text('Don\'t have an account? Sign Up'),
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
