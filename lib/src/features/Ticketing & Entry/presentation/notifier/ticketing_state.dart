// Immutable presentation state for Ticketing & Entry feature

import 'package:flutter/foundation.dart';

@immutable
class Ticket {
  final String id;
  final String eventId;
  final String holderName;
  final DateTime issuedAt;
  final bool validated;
  final Map<String, dynamic>? meta;

  const Ticket({
    required this.id,
    required this.eventId,
    required this.holderName,
    required this.issuedAt,
    this.validated = false,
    this.meta,
  });

  Ticket copyWith({
    String? id,
    String? eventId,
    String? holderName,
    DateTime? issuedAt,
    bool? validated,
    Map<String, dynamic>? meta,
  }) {
    return Ticket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      holderName: holderName ?? this.holderName,
      issuedAt: issuedAt ?? this.issuedAt,
      validated: validated ?? this.validated,
      meta: meta ?? this.meta,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventId': eventId,
      'holderName': holderName,
      'issuedAt': issuedAt.toIso8601String(),
      'validated': validated,
      'meta': meta,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'] as String,
      eventId: map['eventId'] as String,
      holderName: map['holderName'] as String,
      issuedAt: DateTime.parse(map['issuedAt'] as String),
      validated: map['validated'] as bool? ?? false,
      meta: (map['meta'] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ticket &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          eventId == other.eventId &&
          holderName == other.holderName &&
          issuedAt == other.issuedAt &&
          validated == other.validated;

  @override
  int get hashCode =>
      id.hashCode ^
      eventId.hashCode ^
      holderName.hashCode ^
      issuedAt.hashCode ^
      validated.hashCode;
}

@immutable
class TicketingState {
  final List<Ticket> tickets;
  final bool isLoading;
  final String? error;
  final Ticket? selected;

  const TicketingState({
    this.tickets = const [],
    this.isLoading = false,
    this.error,
    this.selected,
  });

  factory TicketingState.initial() => const TicketingState();

TicketingState copyWith({
  List<Ticket>? tickets,
  bool? isLoading,
  String? error,
  Ticket? selected,
}) {
  return TicketingState(
    tickets: tickets ?? this.tickets,
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    selected: selected ?? this.selected,
  );
}

  // Computed helpers
  int get total => tickets.length;
  int get validatedCount => tickets.where((t) => t.validated).length;
  int get pendingCount => total - validatedCount;
  bool get hasError => error != null && error!.isNotEmpty;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketingState &&
          runtimeType == other.runtimeType &&
          listEquals(tickets, other.tickets) &&
          isLoading == other.isLoading &&
          error == other.error &&
          selected == other.selected;

  @override
  int get hashCode =>
      tickets.hashCode ^ isLoading.hashCode ^ (error?.hashCode ?? 0) ^ (selected?.hashCode ?? 0);
}
