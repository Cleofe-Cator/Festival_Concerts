import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';

class BuyTicket {
  final TicketRepository repository;

  BuyTicket(this.repository);

  Future<Either<Failure, Ticket>> call({
    required String eventId,
    required String userId,
    required String ticketType,
  }) async {
    if (eventId.isEmpty || userId.isEmpty || ticketType.isEmpty) {
      return left(ValidationFailure('Missing required fields'));
    }
    return await repository.buyTicket(
      eventId: eventId,
      userId: userId,
      ticketType: ticketType,
    );
  }
}
