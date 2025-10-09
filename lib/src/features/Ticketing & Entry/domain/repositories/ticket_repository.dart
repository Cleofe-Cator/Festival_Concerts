import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';

abstract class TicketRepository {
  /// Attendee buys a ticket for an event
  Future<Either<Failure, Ticket>> buyTicket({
    required String eventId,
    required String userId,
    required String ticketType,
  });

  /// Retrieve all tickets purchased by a specific user
  Future<Either<Failure, List<Ticket>>> getTicketsByUser(String userId);

  /// Retrieve all tickets for a specific event (for organizer)
  Future<Either<Failure, List<Ticket>>> getTicketsByEvent(String eventId);

  /// Verify a ticket at entry (scan QR)
  Future<Either<Failure, Ticket>> verifyTicket(String qrCode);
}
