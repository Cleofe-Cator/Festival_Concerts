import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dashboard_summary_model.dart';
import 'dashboard_remote_data_source.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore firestore;

  DashboardRemoteDataSourceImpl(this.firestore);

  CollectionReference get _tickets => firestore.collection('tickets');
  CollectionReference get _events => firestore.collection('events');

  @override
  Future<DashboardSummaryModel> getDashboardSummary(String organizerId) async {
    try {
      // Get all events by organizer
      final eventsSnapshot =
          await _events.where('organizerId', isEqualTo: organizerId).get();

      if (eventsSnapshot.docs.isEmpty) {
        return DashboardSummaryModel(
          organizerId: organizerId,
          totalTicketsSold: 0,
          totalRevenue: 0.0,
          checkInCount: 0,
          lastUpdated: DateTime.now(),
        );
      }

      final eventIds = eventsSnapshot.docs.map((doc) => doc.id).toList();

      // Get all tickets for those events
      final ticketsSnapshot =
          await _tickets.where('eventId', whereIn: eventIds).get();

      int totalTicketsSold = ticketsSnapshot.docs.length;
      double totalRevenue = 0.0;
      int checkInCount = 0;

      for (var doc in ticketsSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        totalRevenue += (data['price'] as num?)?.toDouble() ?? 0.0;
        if (data['isCheckedIn'] == true) checkInCount++;
      }

      return DashboardSummaryModel(
        organizerId: organizerId,
        totalTicketsSold: totalTicketsSold,
        totalRevenue: totalRevenue,
        checkInCount: checkInCount,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to load dashboard summary: $e');
    }
  }

  @override
  Future<String> exportDashboardReport(String organizerId) async {
    // For Sprint 1 (stub) – this simulates exporting a report
    // Later this could generate a CSV/PDF file using firebase_storage or local file system.
    try {
      await Future.delayed(const Duration(seconds: 1));
      return 'https://fake-download-link.com/reports/$organizerId-summary.pdf';
    } catch (e) {
      throw Exception('Failed to export dashboard report: $e');
    }
  }
}
