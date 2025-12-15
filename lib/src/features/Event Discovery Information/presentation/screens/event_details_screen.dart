import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/event_provider.dart';
import '../providers/favorites_provider.dart';

class EventDetailsScreen extends ConsumerWidget {
  final String eventId;
  const EventDetailsScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);
    final evt = events.firstWhere((e) => e.id == eventId, orElse: () => throw Exception('Not found'));
    final isFav = ref.watch(favoritesProvider).contains(evt.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(evt.name),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
            onPressed: () => ref.read(favoritesProvider.notifier).toggle(evt.id),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(evt.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('When: ${evt.dateTime.toLocal()}'),
          const SizedBox(height: 4),
          Text('Where: ${evt.venue}'),
          const SizedBox(height: 4),
          Text('Tickets available: ${evt.ticketsAvailable}'),
          const SizedBox(height: 12),
          Text('Schedule:', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(evt.scheduleOverview),
        ]),
      ),
    );
  }
}
