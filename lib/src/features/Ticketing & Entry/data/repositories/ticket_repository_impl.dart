import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_remote_data_source.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Ticket>> buyTicket({
    required String eventId,
    required String userId,
    required String ticketType,
  }) async {
    try {
      final result = await remoteDataSource.buyTicket(
        eventId: eventId,
        userId: userId,
        ticketType: ticketType,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getTicketsByUser(String userId) async {
    try {
      final result = await remoteDataSource.getTicketsByUser(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Ticket>>> getTicketsByEvent(String eventId) async {
    try {
      final result = await remoteDataSource.getTicketsByEvent(eventId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Ticket>> verifyTicket(String qrCode) async {
    try {
      final result = await remoteDataSource.verifyTicket(qrCode);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
