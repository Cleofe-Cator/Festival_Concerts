import '../../domain/entities/dashboard_summary.dart';

class AdminDashboardState extends DashboardSummary {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  // ignore: use_super_parameters
  const AdminDashboardState({
    required this.isLoading,
    required super.dashboardData,
    required super.analyticsData,
    required organizerId,
    required totalTicketsSold,
    required totalRevenue,
    required checkInCount,
    required lastUpdated,
    this.errorMessage,
    required this.isSuccess,
  }) : super(
          organizerId: organizerId,
          totalTicketsSold: totalTicketsSold,
          totalRevenue: totalRevenue,
          checkInCount: checkInCount,
          lastUpdated: lastUpdated,
        );

  factory AdminDashboardState.initial() => AdminDashboardState(
        isLoading: false,
        dashboardData: null,
        analyticsData: null,
        organizerId: null,
        totalTicketsSold: null,
        totalRevenue: null,
        checkInCount: null,
        lastUpdated: null,
        errorMessage: null,
        isSuccess: false,
      );

  @override
  AdminDashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,

    // DashboardSummary fields
    dynamic dashboardData,
    dynamic analyticsData,
    String? organizerId,
    int? totalTicketsSold,
    double? totalRevenue,
    int? checkInCount,
    DateTime? lastUpdated,
  }) {
    return AdminDashboardState(
      isLoading: isLoading ?? this.isLoading,
      organizerId: organizerId ?? this.organizerId,
      totalTicketsSold: totalTicketsSold ?? this.totalTicketsSold,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      checkInCount: checkInCount ?? this.checkInCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess, dashboardData: null, analyticsData: null,
    );
  }
}
