import 'package:equatable/equatable.dart';

class DashboardSummary extends Equatable {
  final dynamic dashboardData;
  final dynamic analyticsData;

  final String? organizerId;
  final int? totalTicketsSold;
  final double? totalRevenue;
  final int? checkInCount;
  final DateTime? lastUpdated;

  const DashboardSummary({
    required this.dashboardData,
    required this.analyticsData,
    required this.organizerId,
    required this.totalTicketsSold,
    required this.totalRevenue,
    required this.checkInCount,
    required this.lastUpdated,
  });

  DashboardSummary copyWith({
    dynamic dashboardData,
    dynamic analyticsData,
    String? organizerId,
    int? totalTicketsSold,
    double? totalRevenue,
    int? checkInCount,
    DateTime? lastUpdated,
  }) {
    return DashboardSummary(
      dashboardData: dashboardData ?? this.dashboardData,
      analyticsData: analyticsData ?? this.analyticsData,
      organizerId: organizerId ?? this.organizerId,
      totalTicketsSold: totalTicketsSold ?? this.totalTicketsSold,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      checkInCount: checkInCount ?? this.checkInCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
        dashboardData,
        analyticsData,
        organizerId,
        totalTicketsSold,
        totalRevenue,
        checkInCount,
        lastUpdated,
      ];
}