import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repositories/event_repositories.dart';

class DeleteEvent {
  final EventRepository repository;

  DeleteEvent(this.repository);

  Future<Either<Failure, void>> call(String eventId) async {
    if (eventId.isEmpty) {
      return left(ValidationFailure('Event id cannot be empty'));
    }
    return await repository.deleteEvent(eventId);
  }
}
