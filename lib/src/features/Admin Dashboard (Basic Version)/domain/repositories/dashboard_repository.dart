import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/dashboard_summary.dart';

abstract class DashboardRepository {
  /// Fetch summary metrics for the organizer's dashboard
  Future<Either<Failure, DashboardSummary>> getDashboardSummary(String organizerId);

  /// Export summary report (CSV or PDF)
  /// Returns the file path or download URL (stub for Sprint 1)
  Future<Either<Failure, String>> exportDashboardReport(String organizerId);
}
