import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<EventModel> createEvent(EventModel event);
  Future<List<EventModel>> getEvents();
  Future<EventModel> getEventById(String eventId);
  Future<EventModel> updateEvent(EventModel event);
  Future<void> deleteEvent(String eventId);
  Future<EventModel> publishEvent(String eventId, bool publish);
}
