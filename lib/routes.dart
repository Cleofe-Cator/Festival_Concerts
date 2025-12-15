import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth + Role
import 'src/features/Event Discovery Information/presentation/providers/auth_provider.dart';

// Attendee Screens
import 'src/features/Event Discovery Information/presentation/screens/attendee/home_screen.dart';
import 'src/features/Event Discovery Information/presentation/screens/event_details_screen.dart';

// Organizer Screens
import 'src/features/Event Discovery Information/presentation/screens/organizer/dashboard_screen.dart';
import 'src/features/Event Discovery Information/presentation/screens/organizer/create_event_screen.dart';

// Ticketing & Entry – Attendee
import 'src/features/Ticketing & Entry/presentation/screens/attendee/event_list_screen.dart';
import 'src/features/Ticketing & Entry/presentation/screens/attendee/buy_ticket_screen.dart';
import 'src/features/Ticketing & Entry/presentation/screens/attendee/wallet_screen.dart';

// Ticketing & Entry – Organizer
import 'src/features/Ticketing & Entry/presentation/screens/organizer/ticket_tiers_screen.dart';
import 'src/features/Ticketing & Entry/presentation/screens/organizer/sales_screen.dart';

// Admin Screens
import './src/features/Admin Dashboard (Basic Version)/presentation/screens/dashboard_screen.dart';
import './src/features/Admin Dashboard (Basic Version)/presentation/screens/ticket_sales_screen.dart';
import './src/features/Admin Dashboard (Basic Version)/presentation/screens/check_in_status_screen.dart';
import './src/features/Admin Dashboard (Basic Version)/presentation/screens/export_report_screen.dart';

GoRouter createRouter(WidgetRef ref) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  return GoRouter(
    initialLocation: '/',
    routes: [
      // ============================================================
      // ATTENDEE ROUTES (Event Discovery)
      // ============================================================
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/event/:id',
        name: 'eventDetails',
        builder: (context, state) =>
            EventDetailsScreen(eventId: state.pathParameters['id']!),
      ),

      // ============================================================
      // ATTENDEE ROUTES (Ticketing & Entry)
      // ============================================================
      GoRoute(
        path: '/events',
        name: 'eventList',
        builder: (context, state) => const EventListScreen(),
      ),
      GoRoute(
        path: '/events/:id/buy',
        name: 'buyTicket',
        builder: (context, state) =>
            BuyTicketScreen(eventId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => const WalletScreen(),
      ),

      // ============================================================
      // ORGANIZER ROUTES
      // ============================================================
      GoRoute(
        path: '/organizer',
        name: 'organizerDashboard',
        builder: (context, state) => const OrganizerDashboardScreen(),
        redirect: (context, state) {
          if (user == null || user.role != UserRole.organizer) return '/';
          return null;
        },
      ),

      GoRoute(
        path: '/organizer/create-event',
        name: 'organizerCreate',
        builder: (context, state) => const CreateEventScreen(),
        redirect: (context, state) {
          if (user == null || user.role != UserRole.organizer) return '/';
          return null;
        },
      ),
      GoRoute(
        path: '/organizer/tickets',
        name: 'ticketTiers',
        builder: (context, state) => const TicketTiersScreen(),
        redirect: (context, state) {
          if (user == null || user.role != UserRole.organizer) return '/';
          return null;
        },
      ),
      GoRoute(
        path: '/organizer/sales',
        name: 'organizerSales',
        builder: (context, state) => const OrganizerSalesScreen(),
        redirect: (context, state) {
          if (user == null || user.role != UserRole.organizer) return '/';
          return null;
        },
      ),

      // ============================================================
      // ADMIN ROUTES
      // ============================================================
      GoRoute(
        path: '/admin/dashboard',
        name: 'admin-dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/admin/ticket-sales',
        name: 'ticket-sales',
        builder: (context, state) => const TicketSalesScreen(),
      ),
      GoRoute(
        path: '/admin/check-in-status',
        name: 'check-in-status',
        builder: (context, state) => const CheckInStatusScreen(),
      ),
      GoRoute(
        path: '/admin/export-report',
        name: 'export-report',
        builder: (context, state) => const ExportReportScreen(),
      ),
    ],

    // ============================================================
    // GLOBAL REDIRECT (GUARDS)
    // ============================================================
    redirect: (context, state) {
      final loc = state.uri.toString();

      // Wallet is attendee-only
      if (loc == '/wallet' &&
          (user == null || user.role != UserRole.attendee)) {
        return '/';
      }

      // Organizer protection
      if (loc.startsWith('/organizer') &&
          (user == null || user.role != UserRole.organizer)) {
        return '/';
      }

      return null;
    },
  );
}
