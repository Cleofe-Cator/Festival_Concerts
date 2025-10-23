import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';

class GetTicketsByEvent {
  final TicketRepository repository;

  GetTicketsByEvent(this.repository);

  Future<Either<Failure, List<Ticket>>> call(String eventId) async {
    if (eventId.isEmpty) {
      return left(ValidationFailure('Event ID is required'));
    }
    return await repository.getTicketsByEvent(eventId);
  }
}
