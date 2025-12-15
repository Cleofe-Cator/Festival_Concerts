import '../../domain/entities/dashboard_summary.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardSummaryModel extends DashboardSummary {
  const DashboardSummaryModel({
    required super.organizerId,
    required super.totalTicketsSold,
    required super.totalRevenue,
    required super.checkInCount,
    required super.lastUpdated, 
    required super.dashboardData,
    required super.analyticsData,
  });

  factory DashboardSummaryModel.fromMap(Map<String, dynamic> map) {
    return DashboardSummaryModel(
      organizerId: map['organizerId'] ?? '',
      totalTicketsSold: map['totalTicketsSold'] ?? 0,
      totalRevenue: (map['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      checkInCount: map['checkInCount'] ?? 0,
      lastUpdated: (map['lastUpdated'] is Timestamp)
          ? (map['lastUpdated'] as Timestamp).toDate()
          : DateTime.tryParse(map['lastUpdated']?.toString() ?? '') ??
              DateTime.now(), dashboardData: null, analyticsData: null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'organizerId': organizerId,
      'totalTicketsSold': totalTicketsSold,
      'totalRevenue': totalRevenue,
      'checkInCount': checkInCount,
      'lastUpdated': lastUpdated,
    };
  }
}
