import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';

abstract class EventRepository {
  /// Create a new event. Returns the created Event (with id).
  Future<Either<Failure, Event>> createEvent(Event event);

  /// Get paginated or filtered list of events.
  /// For simplicity this returns all events; extend with params (page, filters) later.
  Future<Either<Failure, List<Event>>> getEvents();

  /// Get a single event by id.
  Future<Either<Failure, Event>> getEventById(String eventId);

  /// Update event fields. Returns the updated Event.
  Future<Either<Failure, Event>> updateEvent(Event event);

  /// Delete an event by id.
  Future<Either<Failure, void>> deleteEvent(String eventId);

  /// Optional: toggle publish state
  Future<Either<Failure, Event>> publishEvent(String eventId, bool publish);
}
