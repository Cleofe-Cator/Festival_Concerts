import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repositories.dart';

class GetEventById {
  final EventRepository repository;

  GetEventById(this.repository);

  Future<Either<Failure, Event>> call(String eventId) async {
    if (eventId.isEmpty) {
      return left(ValidationFailure('Event id cannot be empty'));
    }
    return await repository.getEventById(eventId);
  }
}
