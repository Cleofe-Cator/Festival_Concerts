import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  final String id;
  final String eventId;
  final String userId;
  final String type; // e.g., "VIP", "Regular"
  final double price;
  final String qrCode; // QR or barcode string
  final DateTime purchaseDate;
  final bool isCheckedIn;

  const Ticket({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.type,
    required this.price,
    required this.qrCode,
    required this.purchaseDate,
    this.isCheckedIn = false,
  });

  Ticket copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? type,
    double? price,
    String? qrCode,
    DateTime? purchaseDate,
    bool? isCheckedIn,
  }) {
    return Ticket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      price: price ?? this.price,
      qrCode: qrCode ?? this.qrCode,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      isCheckedIn: isCheckedIn ?? this.isCheckedIn,
    );
  }

  @override
  List<Object?> get props => [
        id,
        eventId,
        userId,
        type,
        price,
        qrCode,
        purchaseDate,
        isCheckedIn,
      ];
}
