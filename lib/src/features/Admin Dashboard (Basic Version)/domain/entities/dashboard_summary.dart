import 'package:equatable/equatable.dart';

class DashboardSummary extends Equatable {
  final String organizerId;
  final int totalTicketsSold;
  final double totalRevenue;
  final int checkInCount;
  final DateTime lastUpdated;

  const DashboardSummary({
    required this.organizerId,
    required this.totalTicketsSold,
    required this.totalRevenue,
    required this.checkInCount,
    required this.lastUpdated,
  });

  DashboardSummary copyWith({
    String? organizerId,
    int? totalTicketsSold,
    double? totalRevenue,
    int? checkInCount,
    DateTime? lastUpdated,
  }) {
    return DashboardSummary(
      organizerId: organizerId ?? this.organizerId,
      totalTicketsSold: totalTicketsSold ?? this.totalTicketsSold,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      checkInCount: checkInCount ?? this.checkInCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props =>
      [organizerId, totalTicketsSold, totalRevenue, checkInCount, lastUpdated];
}

