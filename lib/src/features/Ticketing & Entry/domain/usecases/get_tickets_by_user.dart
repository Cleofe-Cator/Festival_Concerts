import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';

class GetTicketsByUser {
  final TicketRepository repository;

  GetTicketsByUser(this.repository);

  Future<Either<Failure, List<Ticket>>> call(String userId) async {
    if (userId.isEmpty) {
      return left(ValidationFailure('User ID is required'));
    }
    return await repository.getTicketsByUser(userId);
  }
}
