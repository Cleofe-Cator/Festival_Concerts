import 'package:cloud_firestore/cloud_firestore.dart';
import 'ticket_remote_data_source.dart';
import '../models/ticket_model.dart';
import 'package:uuid/uuid.dart';

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final FirebaseFirestore firestore;

  TicketRemoteDataSourceImpl(this.firestore);

  CollectionReference get _tickets => firestore.collection('tickets');
  final _uuid = const Uuid();

  @override
  Future<TicketModel> buyTicket({
    required String eventId,
    required String userId,
    required String ticketType,
  }) async {
    try {
      final id = _uuid.v4();
      final qrCode = 'QR-$id';
      // Example: Pricing logic can be dynamic, here we assume based on ticket type
      double price = ticketType.toLowerCase() == 'vip' ? 2000.0 : 1000.0;

      final ticket = TicketModel(
        id: id,
        eventId: eventId,
        userId: userId,
        type: ticketType,
        price: price,
        qrCode: qrCode,
        purchaseDate: DateTime.now(),
        isCheckedIn: false,
      );

      await _tickets.doc(id).set(ticket.toMap());
      return ticket;
    } catch (e) {
      throw Exception('Failed to buy ticket: $e');
    }
  }

  @override
  Future<List<TicketModel>> getTicketsByUser(String userId) async {
    final querySnapshot =
        await _tickets.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs
        .map((doc) => TicketModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<TicketModel>> getTicketsByEvent(String eventId) async {
    final querySnapshot =
        await _tickets.where('eventId', isEqualTo: eventId).get();

    return querySnapshot.docs
        .map((doc) => TicketModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TicketModel> verifyTicket(String qrCode) async {
    final querySnapshot =
        await _tickets.where('qrCode', isEqualTo: qrCode).get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Ticket not found');
    }

    final doc = querySnapshot.docs.first;
    final data = doc.data() as Map<String, dynamic>;
    final ticket = TicketModel.fromMap(data);

    if (ticket.isCheckedIn) {
      throw Exception('Ticket already checked in');
    }

    await _tickets.doc(ticket.id).update({'isCheckedIn': true});
    final updatedDoc = await _tickets.doc(ticket.id).get();
    return TicketModel.fromMap(updatedDoc.data() as Map<String, dynamic>);
  }
}
