import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/ticketing_state.dart';
import '../../domain/usecases/buy_ticket.dart';
import '../../domain/usecases/get_tickets_by_event.dart';
import '../../domain/usecases/get_tickets_by_user.dart';
import '../../domain/usecases/verify_ticket.dart';

class TicketingNotifier extends StateNotifier<TicketingState> {
  final BuyTicket createTicket;
  final GetTicketsByEvent getTickets; 
  final GetTicketsByUser getTicketByUser;
  final VerifyTicket validateEntry;

  TicketingNotifier({
    required this.createTicket,
    required this.getTickets,
    required this.getTicketByUser,
    required this.validateEntry,
  }) : super(TicketingState.initial());

  Future<void> loadTickets({String? eventId}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      if (eventId == null) {
        state = state.copyWith(isLoading: false, error: 'Event ID is required');
        return;
      }
      final result = await getTickets.call(eventId);
      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, error: failure.toString());
        },
        (list) {
          state = state.copyWith(tickets: list as List<Ticket>?, isLoading: false);
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> create(Ticket ticket) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final _ = await create(ticket);
      state = state.copyWith(tickets: [...state.tickets], isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

 Future<void> validate(String ticketId) async {
  state = state.copyWith(isLoading: true, error: null);
  try {
    final result = await validateEntry.call(ticketId);

    result.fold(
      (failure) {
        // Handle failure
        state = state.copyWith(isLoading: false, error: failure.toString());
      },
      (validatedTicket) {
        // Update the tickets list
        state = state.copyWith( isLoading: false);
      },
    );
  } catch (e) {
    state = state.copyWith(isLoading: false, error: e.toString());
  }
}
}
