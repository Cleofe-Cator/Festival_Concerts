import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repositories.dart';
import '../datasources/event_remote_data_source.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Event>> createEvent(Event event) async {
    try {
      final eventModel = EventModel(
        id: event.id,
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        venue: event.venue,
        imageUrls: event.imageUrls,
        ticketTypes: event.ticketTypes,
        organizerId: event.organizerId,
        isPublished: event.isPublished,
      );
      final result = await remoteDataSource.createEvent(eventModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      final result = await remoteDataSource.getEvents();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById(String eventId) async {
    try {
      final result = await remoteDataSource.getEventById(eventId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> updateEvent(Event event) async {
    try {
      final model = EventModel(
        id: event.id,
        title: event.title,
        description: event.description,
        startDate: event.startDate,
        endDate: event.endDate,
        venue: event.venue,
        imageUrls: event.imageUrls,
        ticketTypes: event.ticketTypes,
        organizerId: event.organizerId,
        isPublished: event.isPublished,
      );
      final result = await remoteDataSource.updateEvent(model);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEvent(String eventId) async {
    try {
      await remoteDataSource.deleteEvent(eventId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Event>> publishEvent(
      String eventId, bool publish) async {
    try {
      final result = await remoteDataSource.publishEvent(eventId, publish);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
