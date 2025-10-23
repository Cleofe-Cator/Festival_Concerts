import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime? endDate;
  final String venue;
  final List<String> imageUrls;
  final List<TicketType> ticketTypes;
  final String organizerId;
  final bool isPublished;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.venue,
    this.imageUrls = const [],
    this.ticketTypes = const [],
    required this.organizerId,
    this.isPublished = false,
  });

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? venue,
    List<String>? imageUrls,
    List<TicketType>? ticketTypes,
    String? organizerId,
    bool? isPublished,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      venue: venue ?? this.venue,
      imageUrls: imageUrls ?? this.imageUrls,
      ticketTypes: ticketTypes ?? this.ticketTypes,
      organizerId: organizerId ?? this.organizerId,
      isPublished: isPublished ?? this.isPublished,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        venue,
        imageUrls,
        ticketTypes,
        organizerId,
        isPublished,
      ];
}

class TicketType extends Equatable {
  final String id;
  final String name;
  final int quantity;
  final double price;

  const TicketType({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  TicketType copyWith({
    String? id,
    String? name,
    int? quantity,
    double? price,
  }) {
    return TicketType(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, quantity, price];
}
