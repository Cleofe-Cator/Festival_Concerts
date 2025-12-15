import 'package:go_router/go_router.dart';
import '../screens/dashboard_screen.dart';
import '../screens/ticket_sales_screen.dart';
import '../screens/check_in_status_screen.dart';
import '../screens/export_report_screen.dart';

class AdminRoutes {
  static const String dashboard = '/admin/dashboard';
  static const String ticketSales = '/admin/ticket-sales';
  static const String checkInStatus = '/admin/check-in-status';
  static const String exportReport = '/admin/export-report';

  static List<GoRoute> routes = [
    GoRoute(
      path: dashboard,
      name: 'admin-dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: ticketSales,
      name: 'ticket-sales',
      builder: (context, state) => const TicketSalesScreen(),
    ),
    GoRoute(
      path: checkInStatus,
      name: 'check-in-status',
      builder: (context, state) => const CheckInStatusScreen(),
    ),
    GoRoute(
      path: exportReport,
      name: 'export-report',
      builder: (context, state) => const ExportReportScreen(),
    ),
  ];
}
