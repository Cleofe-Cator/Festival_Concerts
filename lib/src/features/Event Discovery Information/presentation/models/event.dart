class Event {
  final String id;
  final String name;
  final DateTime dateTime;
  final String venue;
  final int ticketsAvailable;
  final String scheduleOverview;
  final String organizerId;

  Event({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.venue,
    required this.ticketsAvailable,
    required this.scheduleOverview,
    required this.organizerId,
  });
}
