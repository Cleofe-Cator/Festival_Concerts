import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../themes/themes.dart';

class CheckInStatusScreen extends ConsumerStatefulWidget {
  const CheckInStatusScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckInStatusScreen> createState() => _CheckInStatusScreenState();
}

class _CheckInStatusScreenState extends ConsumerState<CheckInStatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adminDashboardNotifierProvider.notifier).fetchSystemAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminDashboardNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In Status'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(adminDashboardNotifierProvider.notifier).fetchSystemAnalytics(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? Center(child: Text(state.errorMessage!))
              : _buildCheckInContent(context, state),
    );
  }

  Widget _buildCheckInContent(BuildContext context, state) {
    return RefreshIndicator(
      onRefresh: () async => ref.read(adminDashboardNotifierProvider.notifier).fetchSystemAnalytics(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckInOverview(),
            const SizedBox(height: 32),
            _buildQRScanStats(),
            const SizedBox(height: 32),
            _buildTimelineStats(),
            const SizedBox(height: 32),
            _buildCheckInByCategory(),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Check-In Status',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [AppTheme.secondaryColor, AppTheme.secondaryColor.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: 0.77,
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '77%',
                          style: AppTheme.headlineSmall.copyWith(
                            color: Colors.white,
                            fontSize: 36,
                          ),
                        ),
                        Text(
                          'Check-In Rate',
                          style: AppTheme.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatColumn('Checked In', '189', Colors.white),
                    const SizedBox(width: 1),
                    _buildStatColumn('Pending', '56', Colors.white.withValues(alpha: 0.7)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildQRScanStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QR Scan Statistics',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        _buildStatCard('Total QR Scans', '189', Icons.qr_code_2, Colors.blue),
        const SizedBox(height: 12),
        _buildStatCard('Successful Scans', '187', Icons.check_circle, Colors.green),
        const SizedBox(height: 12),
        _buildStatCard('Failed Scans', '2', Icons.cancel, Colors.red),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTheme.bodySmall),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Check-In Timeline',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        _buildTimelineItem('8:00 AM - 10:00 AM', 42, 'Early Morning'),
        const SizedBox(height: 12),
        _buildTimelineItem('10:00 AM - 12:00 PM', 78, 'Morning Peak'),
        const SizedBox(height: 12),
        _buildTimelineItem('12:00 PM - 2:00 PM', 45, 'Afternoon'),
        const SizedBox(height: 12),
        _buildTimelineItem('2:00 PM - 4:00 PM', 24, 'Late Afternoon'),
      ],
    );
  }

  Widget _buildTimelineItem(String timeRange, int count, String period) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeRange, style: AppTheme.bodyMedium),
                    Text(period, style: AppTheme.bodySmall.copyWith(color: Colors.grey)),
                  ],
                ),
                Text(
                  '$count Scans',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInByCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Check-In by Category',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        _buildCategoryCheckIn('VIP', 48, 50),
        const SizedBox(height: 12),
        _buildCategoryCheckIn('Standard', 115, 150),
        const SizedBox(height: 12),
        _buildCategoryCheckIn('Student', 26, 45),
      ],
    );
  }

  Widget _buildCategoryCheckIn(String category, int checkedIn, int total) {
    final percentage = ((checkedIn / total) * 100).toStringAsFixed(1);

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category, style: AppTheme.bodyMedium),
                Text('$checkedIn / $total', style: AppTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: checkedIn / total,
                minHeight: 8,
                backgroundColor: Colors.grey.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$percentage% Checked In',
              style: AppTheme.bodySmall.copyWith(color: AppTheme.secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
