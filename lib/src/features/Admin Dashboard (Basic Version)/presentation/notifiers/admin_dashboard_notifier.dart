import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/export_dashboard_report.dart';
import '../../domain/usecases/get_dashboard_summary.dart';
import '../state/admin_dashboard_state.dart';

class AdminDashboardNotifier extends StateNotifier<AdminDashboardState> {
  final GetDashboardSummary getDashboardUsecase;
  final ExportDashboardReport exportDashboardUsecase;

  AdminDashboardNotifier({
    required this.getDashboardUsecase,
    required this.exportDashboardUsecase,
  }) : super(AdminDashboardState.initial());

  /// -------------------------------
  /// LOAD DASHBOARD SUMMARY
  /// -------------------------------
  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final result = await getDashboardUsecase.call('');

      // Handle Either<Failure, DashboardSummary>
      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: failure.toString(),
            isSuccess: false,
          );
        },
        (summary) {
          state = state.copyWith(
            isLoading: false,
            isSuccess: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      );
    }
  }

  /// -------------------------------
  /// EXPORT DASHBOARD REPORT
  /// -------------------------------
  Future<void> exportReport() async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      final result = await exportDashboardUsecase.call('');

      result.fold(
        (failure) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: failure.toString(),
            isSuccess: false,
          );
        },
        (filePath) {
          state = state.copyWith(
            isLoading: false,
            isSuccess: true,
          );

          // Optionally return file path for UI snackbars
          // ignore: avoid_print
          print("Report exported: $filePath");
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isSuccess: false,
      );
    }
  }

  void fetchSystemAnalytics() {}

  void fetchDashboardData() {}
}
