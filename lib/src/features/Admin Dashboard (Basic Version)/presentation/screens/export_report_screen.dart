import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import '../providers/admin_dashboard_provider.dart';
import '../../themes/themes.dart';

class ExportReportScreen extends ConsumerStatefulWidget {
  const ExportReportScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ExportReportScreen> createState() => _ExportReportScreenState();
}

class _ExportReportScreenState extends ConsumerState<ExportReportScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminDashboardNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Export Report'),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Generate Report',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Customize and export your dashboard report in your preferred format.',
                style: AppTheme.bodyMedium.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),
              _buildFormatSection(),
              const SizedBox(height: 24),
              _buildDateRangeSection(),
              const SizedBox(height: 24),
              _buildIncludeDataSection(),
              const SizedBox(height: 32),
              _buildActionButtons(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Export Format',
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        FormBuilderRadioGroup(
          name: 'export_format',
          options: const ['CSV', 'PDF'].asMap().entries.map(
            (e) => FormBuilderFieldOption(value: e.value),
          ).toList(),
          onChanged: (value) => setState(() {}),
          validator: FormBuilderValidators.required(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: 'Select Format',
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FormBuilderDateTimePicker(
                  name: 'start_date',
                  inputType: InputType.date,
                  format: null,
                  validator: FormBuilderValidators.required(),
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FormBuilderDateTimePicker(
                name: 'end_date',
                inputType: InputType.date,
                format: null,
                validator: FormBuilderValidators.required(),
                decoration: InputDecoration(
                  labelText: 'End Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIncludeDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Include in Report',
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        FormBuilderCheckboxGroup<String>(
          name: 'include_data',
          options: const [
            'Ticket Sales Summary',
            'Check-In Statistics',
            'Revenue Report',
            'Attendee Details',
            'QR Scan Logs',
          ].map(
            (e) => FormBuilderFieldOption<String>(value: e),
          ).toList(),
          validator: FormBuilderValidators.minLength(1),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: 'Select Data to Include',
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isExporting ? null : () => _handleExport(context, state),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isExporting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Generate & Download Report',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _handleExport(BuildContext context, state) async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isExporting = true);

      try {

        // TODO: Call export use case with form data
        // await ref.read(adminDashboardNotifierProvider.notifier)
        //     .exportDashboardReport(formData);

        // Simulate export delay
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Report exported successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error exporting report: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isExporting = false);
        }
      }
    }
  }
}
