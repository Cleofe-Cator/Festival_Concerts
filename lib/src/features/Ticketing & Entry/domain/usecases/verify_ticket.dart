import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';

class VerifyTicket {
  final TicketRepository repository;

  VerifyTicket(this.repository);

  Future<Either<Failure, Ticket>> call(String qrCode) async {
    if (qrCode.isEmpty) {
      return left(ValidationFailure('QR code cannot be empty'));
    }
    return await repository.verifyTicket(qrCode);
  }
}
