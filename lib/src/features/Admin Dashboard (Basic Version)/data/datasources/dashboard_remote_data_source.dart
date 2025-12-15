import '../models/dashboard_summary_model.dart';

abstract class DashboardRemoteDataSource {
  DashboardRemoteDataSource(DashboardRemoteDataSource datasource);

  Future<DashboardSummaryModel> getDashboardSummary(String organizerId);

  /// Exports the dashboard report and returns a downloadable URL or file path
  Future<String> exportDashboardReport(String organizerId);
}
