import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/admin_dashboard_provider.dart';
import '../../themes/themes.dart';

class TicketSalesScreen extends ConsumerWidget {
  const TicketSalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(adminDashboardNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Sales Summary'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? Center(child: Text(state.errorMessage!))
              : _buildTicketSalesContent(context),
    );
  }

  Widget _buildTicketSalesContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTicketStats(),
          const SizedBox(height: 32),
          _buildSalesBreakdown(),
          const SizedBox(height: 32),
          _buildDetailedTable(),
        ],
      ),
    );
  }

  Widget _buildTicketStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sales Overview',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Total Capacity', '300', AppTheme.primaryColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard('Sold', '245', Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Available', '55', Colors.orange),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard('Sales Rate', '81.67%', AppTheme.secondaryColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.withValues(alpha: 0.1),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
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
    );
  }

  Widget _buildSalesBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ticket Category Breakdown',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        _buildBreakdownItem('VIP Tickets', 50, 50, Colors.purple),
        const SizedBox(height: 12),
        _buildBreakdownItem('Standard Tickets', 150, 180, Colors.blue),
        const SizedBox(height: 12),
        _buildBreakdownItem('Student Tickets', 45, 70, Colors.green),
      ],
    );
  }

  Widget _buildBreakdownItem(String label, int sold, int capacity, Color color) {
    final percentage = ((sold / capacity) * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.bodyMedium),
            Text('$sold / $capacity', style: AppTheme.bodySmall),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: sold / capacity,
            minHeight: 8,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage% Sold',
          style: AppTheme.bodySmall.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildDetailedTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed Sales Data',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Sold'), numeric: true),
                DataColumn(label: Text('Capacity'), numeric: true),
                DataColumn(label: Text('Rate'), numeric: true),
              ],
              rows: [
                _buildDataRow('VIP', 50, 50),
                _buildDataRow('Standard', 150, 180),
                _buildDataRow('Student', 45, 70),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildDataRow(String category, int sold, int capacity) {
    final percentage = ((sold / capacity) * 100).toStringAsFixed(1);

    return DataRow(
      cells: [
        DataCell(Text(category)),
        DataCell(Text(sold.toString())),
        DataCell(Text(capacity.toString())),
        DataCell(Text('$percentage%')),
      ],
    );
  }
}
