import 'package:flutter/foundation.dart';


enum EventStatus { initial, loading, success, failure }

@immutable
class EventState {
  final EventState? selectedEvent;
  final List<EventState> events;
  final EventStatus status;
  final String? errorMessage;
  final Map<String, dynamic>? appliedFilters;

  const EventState({
    this.selectedEvent,
    this.events = const [],
    this.status = EventStatus.initial,
    this.errorMessage,
    this.appliedFilters,
  });

  EventState copyWith({
    EventState? selectedEvent,
    List<EventState>? events,
    EventStatus? status,
    String? errorMessage,
    Map<String, dynamic>? appliedFilters,
  }) {
    return EventState(
      selectedEvent: selectedEvent ?? this.selectedEvent,
      events: events ?? this.events,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      appliedFilters: appliedFilters ?? this.appliedFilters,
    );
  }
}
