import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class OrganizerDashboardScreen extends ConsumerWidget {
  const OrganizerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);
    final user = ref.watch(authProvider).user;
    final myEvents = user == null ? [] : events.where((e) => e.organizerId == user.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizer Dashboard'),
        actions: [
            TextButton.icon(
              onPressed: () => context.push('/organizer/tickets'),
              icon: const Icon(Icons.confirmation_num_outlined),
              label: const Text('Ticket Tiers'),
             style: TextButton.styleFrom(
                foregroundColor: Colors.white, // makes text visible on AppBar
              ),
           ),
       ],
      ),
      body: ListView.builder(
        itemCount: myEvents.length,
        itemBuilder: (context, i) {
          final e = myEvents[i];
          return ListTile(
            title: Text(e.name),
            subtitle: Text('${e.venue} · ${e.dateTime}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/organizer/create'),
        icon: const Icon(Icons.add),
        label: const Text('Create Event'),
      ),
    );
  }
}
