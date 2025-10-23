import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/event.dart';
import '../repositories/event_repositories.dart';

class UpdateEvent {
  final EventRepository repository;

  UpdateEvent(this.repository);

  Future<Either<Failure, Event>> call(Event event) async {
    if (event.id.isEmpty) {
      return left(ValidationFailure('Event id is required for update'));
    }
    // more validation if needed
    return await repository.updateEvent(event);
  }
}
