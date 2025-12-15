import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Event Discovery Information/presentation/providers/event_provider.dart';
import 'package:go_router/go_router.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, i) {
          final e = events[i];
          return ListTile(
            title: Text(e.name),
            subtitle: Text('${e.venue} · ${e.dateTime}'),
            trailing: ElevatedButton(
              child: const Text('Buy'),
              onPressed: () => context.push('/events/${e.id}/buy'),
            ),
          );
        },
      ),
    );
  }
}
