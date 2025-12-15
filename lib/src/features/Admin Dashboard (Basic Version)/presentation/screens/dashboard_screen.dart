import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../themes/themes.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminDashboardNotifierProvider.notifier).fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminDashboardNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            onPressed: () => context.push('/admin/export-report'),
            tooltip: 'Export Report',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(adminDashboardNotifierProvider.notifier).fetchDashboardData(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? _buildErrorWidget(state.errorMessage!)
              : _buildDashboardContent(context, state),
    );
  }

  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: AppTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: AppTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => ref.read(adminDashboardNotifierProvider.notifier).fetchDashboardData(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, state) {
  return RefreshIndicator(
    onRefresh: () async => ref.read(adminDashboardNotifierProvider.notifier).fetchDashboardData(),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard Overview',
            style: AppTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          _buildSummaryCards(context),
          const SizedBox(height: 32),

          // ✅ New visible buttons section
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/admin/ticket-sales'),
                  icon: const Icon(Icons.local_activity),
                  label: const Text('View Ticket Sales'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push('/admin/check-in-status'),
                  icon: const Icon(Icons.qr_code_2),
                  label: const Text('Check-In Status'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          _buildQuickActionsSection(context),
        ],
      ),
    ),
  );
}

  Widget _buildSummaryCards(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.push('/admin/ticket-sales'),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor, AppTheme.primaryColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ticket Sales',
                        style: AppTheme.titleLarge.copyWith(color: Colors.white),
                      ),
                      Icon(Icons.local_activity, color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${_getSoldTickets()} Sold',
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_getAvailableTickets()} Available',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => context.push('/admin/check-in-status'),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [AppTheme.secondaryColor, AppTheme.secondaryColor.withValues(alpha: 0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Check-In Status',
                        style: AppTheme.titleLarge.copyWith(color: Colors.white),
                      ),
                      Icon(Icons.qr_code_2, color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${_getCheckedInCount()} Checked In',
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_getCheckInPercentage()}% Check-in Rate',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => context.push('/admin/export-report'),
                icon: const Icon(Icons.download),
                label: const Text('Export Report'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => ref.read(adminDashboardNotifierProvider.notifier).fetchDashboardData(),
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _getSoldTickets() => 245; // TODO: Get from state.dashboardData
  int _getAvailableTickets() => 55; // TODO: Get from state.dashboardData
  int _getCheckedInCount() => 189; // TODO: Get from state.dashboardData
  int _getCheckInPercentage() => 77; // TODO: Get from state.dashboardData
}
