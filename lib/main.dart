import 'package:fc_app/src/features/Event%20Discovery%20Information/presentation/screens/attendee/home_screen.dart';
import 'package:fc_app/src/features/user/presentation/screens/login_screen.dart';
import 'package:fc_app/src/features/user/presentation/screens/organizer_dashboard_screen.dart';
import 'package:fc_app/src/features/user/presentation/screens/signup_screen.dart' hide userProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
        GoRoute(path: '/event-discovery', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/organizer', builder: (context, state) => const OrganizerDashboardScreen()),
      ],
      redirect: (context, state) {
        final userState = ref.read(userProvider);
        final loggingIn = state.uri.toString() == '/login' || state.uri.toString() == '/signup';

        if (userState.user == null && !loggingIn) {
          return '/login'; // force login if no user
        }

        if (userState.user != null) {
          if (userState.user!['role'] == 'organizer' && state.uri.toString() == '/organizer-dashboard') {
            return '/organizer';
          }
          if (userState.user!['role'] == 'attendee' && state.uri.toString() == '/home') {
            return '/event-discovery';
          }
        }

        return null;
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Concert & Festival App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D7A66)),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.4),
        ),
      ),
      routerConfig: router,
    );
  }
}
