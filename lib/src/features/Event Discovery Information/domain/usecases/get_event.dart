import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repositories.dart';

class CreateEvent {
  final EventRepository repository;

  CreateEvent(this.repository);

  Future<Either<Failure, Event>> call(Event event) async {
    // add any domain-level validation here if needed
    if (event.title.trim().isEmpty) {
      return left(ValidationFailure('Event title cannot be empty'));
    }
    if (event.startDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      // example validation: start date cannot be in the past (adjust rule as needed)
      return left(ValidationFailure('Event start date cannot be in the past'));
    }
    return await repository.createEvent(event);
  }
}
