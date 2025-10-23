import '../models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<TicketModel> buyTicket({
    required String eventId,
    required String userId,
    required String ticketType,
  });

  Future<List<TicketModel>> getTicketsByUser(String userId);

  Future<List<TicketModel>> getTicketsByEvent(String eventId);

  Future<TicketModel> verifyTicket(String qrCode);
}
