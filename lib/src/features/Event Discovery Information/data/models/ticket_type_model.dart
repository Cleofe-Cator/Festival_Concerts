import '../../domain/entities/event.dart';

class TicketTypeModel extends TicketType {
  const TicketTypeModel({
    required super.id,
    required super.name,
    required super.quantity,
    required super.price,
  });

  factory TicketTypeModel.fromMap(Map<String, dynamic> map) {
    return TicketTypeModel(
      id: map['id'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      price: (map['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
