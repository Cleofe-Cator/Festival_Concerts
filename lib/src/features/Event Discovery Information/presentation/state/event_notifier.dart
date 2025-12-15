import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'event_state.dart';
import '../../domain/usecases/create_event.dart';
import '../../domain/usecases/get_event_id.dart';
import '../../domain/usecases/get_event.dart';
import '../../domain/usecases/delete_event.dart';
import '../../domain/usecases/update_event.dart';

class EventNotifier extends StateNotifier<EventState> {
  final GetEventById getEventid;
  final CreateEvent createEvent;
  final DeleteEvent deleteEvent;
  final UpdateEvent updateEvent;
  final GetEvents getEvent;

   EventNotifier({
    required this.createEvent,
    required this.getEventid,
    required this.deleteEvent,
    required this.updateEvent,
    required this.getEvent,
    
  }) : super(const EventState());

  // Helper to handle either-style (fold) or direct-return results.
  void _handleResult(
    dynamic result, {
    required void Function(dynamic success) onSuccess,
  }) {
    // treat null as success (usecases that return void / no value)
    if (result == null) {
      onSuccess(null);
      return;
    }

    // direct domain type or list
    if (result is EventState || result is List<EventState>) {
      onSuccess(result);
      return;
    }

    // attempt fold for Either-like results, fallback to treating result as success
    try {
      (result as dynamic).fold(
        (failure) => state = state.copyWith(status: EventStatus.failure, errorMessage: failure.toString()),
        (value) => onSuccess(value),
      );
    } catch (_) {
      // fallback: treat result as success value
      try {
        onSuccess(result);
      } catch (e) {
        state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
      }
    }
  }

  Future<void> fetchAll() async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    try {
      _handleResult((events) {
        state = state.copyWith(events: (events as List<EventState>), status: EventStatus.success);
      }, onSuccess: (success) {  });
    } catch (e) {
      state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> fetchById(String id) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    try {
      final result = await getEventid.call(id);
      _handleResult(result, onSuccess: (event) {
        state = state.copyWith(selectedEvent: event as EventState, status: EventStatus.success);
      });
    } catch (e) {
      state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> search(String query) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    try {
      _handleResult((events) {
        state = state.copyWith(events: (events as List<EventState>), status: EventStatus.success);
      }, onSuccess: (success) {  });
    } catch (e) {
      state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> applyFilters(Map<String, dynamic> filters) async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    try {
      _handleResult((events) {
        state = state.copyWith(
          events: (events as List<EventState>),
          appliedFilters: filters,
          status: EventStatus.success,
        );
      }, onSuccess: (success) {  });
    } catch (e) {
      state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
    }
  }

  Future<void> fetchFeatured() async {
    state = state.copyWith(status: EventStatus.loading, errorMessage: null);
    try {
      _handleResult((events) {
        state = state.copyWith(events: (events as List<EventState>), status: EventStatus.success);
      }, onSuccess: (success) {  });
    } catch (e) {
      state = state.copyWith(status: EventStatus.failure, errorMessage: e.toString());
    }
  }
}
