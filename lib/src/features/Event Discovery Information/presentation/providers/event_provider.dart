import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event.dart';
import 'package:uuid/uuid.dart';

class EventListNotifier extends StateNotifier<List<Event>> {
  EventListNotifier() : super([]) {
    // seed with mock events
    state = [
      Event(
        id: 'e1',
        name: 'Summer Jazz Night',
        dateTime: DateTime.now().add(const Duration(days: 5, hours: 19)),
        venue: 'City Park Amphitheater',
        ticketsAvailable: 120,
        scheduleOverview: '6:00 PM - Doors\n7:00 PM - Main Performance\n9:00 PM - Afterparty',
        organizerId: 'u_org',
      ),
      Event(
        id: 'e2',
        name: 'Tech Talks Meetup',
        dateTime: DateTime.now().add(const Duration(days: 12, hours: 18)),
        venue: 'Innovation Hub',
        ticketsAvailable: 50,
        scheduleOverview: '6:00 PM - Networking\n6:30 PM - Talks\n8:30 PM - Q&A',
        organizerId: 'u_org',
      ),
    ];
  }

  List<Event> upcoming() => state..sort((a, b) => a.dateTime.compareTo(b.dateTime));


  void createEvent({
    required String name,
    required DateTime dateTime,
    required String venue,
    required int tickets,
    required String scheduleOverview,
    required String organizerId,
  }) {
    final id = const Uuid().v4();
    final newEvent = Event(
      id: id,
      name: name,
      dateTime: dateTime,
      venue: venue,
      ticketsAvailable: tickets,
      scheduleOverview: scheduleOverview,
      organizerId: organizerId,
    );
    state = [...state, newEvent];
  }
}

final eventListProvider = StateNotifierProvider<EventListNotifier, List<Event>>((ref) => EventListNotifier());
