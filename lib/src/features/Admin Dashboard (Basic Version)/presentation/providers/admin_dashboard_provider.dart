import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/datasources/dashboard_remote_data_source_impl.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/export_dashboard_report.dart';
import '../../domain/usecases/get_dashboard_summary.dart';
import '../state/admin_dashboard_state.dart';
import '../notifiers/admin_dashboard_notifier.dart';

// Data Source Providers
final firebaseAdminDatasourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  return DashboardRemoteDataSourceImpl(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  );
});

// Repository Providers
final adminRepositoryProvider = Provider<DashboardRepository>((ref) {
  final datasource = ref.watch(firebaseAdminDatasourceProvider);
   return DashboardRepositoryImpl(datasource);
});

// Use Case Providers
final getAdminDashboardUsecaseProvider = Provider<GetDashboardSummary>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return GetDashboardSummary(repository);
});

final eportAdminDashboardUsecaseProvider = Provider<ExportDashboardReport>((ref) {
  final repository = ref.watch(adminRepositoryProvider);
  return ExportDashboardReport(repository);
});

// State Notifier Provider
final adminDashboardNotifierProvider = 
    StateNotifierProvider<AdminDashboardNotifier, AdminDashboardState>((ref) {
  final getDashboardUsecase = ref.watch(getAdminDashboardUsecaseProvider);
  final exportDashboardUsecase = ref.watch(eportAdminDashboardUsecaseProvider);
  
  return AdminDashboardNotifier(
    getDashboardUsecase: getDashboardUsecase,
    exportDashboardUsecase: exportDashboardUsecase,

  );
});
