import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/datasources/ticket_remote_data_source_impl.dart';
import '../../data/datasources/ticket_remote_data_source.dart';
import '../../data/repositories/ticket_repository_impl.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../../domain/usecases/buy_ticket.dart';
import '../../domain/usecases/get_tickets_by_event.dart';
import '../../domain/usecases/get_tickets_by_user.dart';
import '../../domain/usecases/verify_ticket.dart';
import '../notifier/ticketing_notifier.dart';
import '../notifier/ticketing_state.dart';

// Data source provider (Firebase placeholder)
final firebaseTicketDataSourceProvider = Provider<TicketRemoteDataSource>((ref) {
  return TicketRemoteDataSourceImpl(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  );
});

// Repository provider
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final ds = ref.read(firebaseTicketDataSourceProvider);
  return TicketRepositoryImpl(ds);
});

// Use case providers
final createTicketUseCaseProvider = Provider((ref) => BuyTicket(ref.read(ticketRepositoryProvider)));
final getTicketsUseCaseProvider = Provider((ref) => GetTicketsByEvent(ref.read(ticketRepositoryProvider)));
final getTicketByUseCaseProvider = Provider((ref) => GetTicketsByUser(ref.read(ticketRepositoryProvider)));
final validateEntryUseCaseProvider = Provider((ref) => VerifyTicket(ref.read(ticketRepositoryProvider)));

// StateNotifier provider wiring all use cases into the notifier
final ticketingNotifierProvider = StateNotifierProvider<TicketingNotifier, TicketingState>((ref) {
  return TicketingNotifier(
    createTicket: ref.read(createTicketUseCaseProvider),
    getTickets: ref.read(getTicketsUseCaseProvider),
    getTicketByUser: ref.read(getTicketByUseCaseProvider),
    validateEntry: ref.read(validateEntryUseCaseProvider),
  );
});
