import '../../domain/entities/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ticket_type_model.dart';

class EventModel extends Event {
  const EventModel({
    required super.id,
    required super.title,
    required super.description,
    required super.startDate,
    super.endDate,
    required super.venue,
    required super.imageUrls,
    required super.ticketTypes,
    required super.organizerId,
    required super.isPublished,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: map['endDate'] != null
          ? (map['endDate'] as Timestamp).toDate()
          : null,
      venue: map['venue'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      ticketTypes: (map['ticketTypes'] as List<dynamic>?)
              ?.map((t) => TicketTypeModel.fromMap(t))
              .toList() ??
          [],
      organizerId: map['organizerId'] ?? '',
      isPublished: map['isPublished'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'venue': venue,
      'imageUrls': imageUrls,
      'ticketTypes':
          ticketTypes.map((t) => (t as TicketTypeModel).toMap()).toList(),
      'organizerId': organizerId,
      'isPublished': isPublished,
    };
  }
}
