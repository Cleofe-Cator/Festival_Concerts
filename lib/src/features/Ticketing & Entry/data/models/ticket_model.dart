import '../../domain/entities/ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.eventId,
    required super.userId,
    required super.type,
    required super.price,
    required super.qrCode,
    required super.purchaseDate,
    required super.isCheckedIn,
  });

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] ?? '',
      eventId: map['eventId'] ?? '',
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      price: (map['price'] as num).toDouble(),
      qrCode: map['qrCode'] ?? '',
      purchaseDate: (map['purchaseDate'] as Timestamp).toDate(),
      isCheckedIn: map['isCheckedIn'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'userId': userId,
      'type': type,
      'price': price,
      'qrCode': qrCode,
      'purchaseDate': purchaseDate,
      'isCheckedIn': isCheckedIn,
    };
  }
}
