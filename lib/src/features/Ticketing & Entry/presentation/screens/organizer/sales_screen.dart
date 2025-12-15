import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../ticketing & entry/presentation/providers/ticketing_providers.dart';

class OrganizerSalesScreen extends ConsumerWidget {
  const OrganizerSalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticketingNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Sales')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total tickets: ${state.total}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Validated: ${state.validatedCount}'),
            const SizedBox(height: 8),
            Text('Pending: ${state.pendingCount}'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: state.tickets.length,
                itemBuilder: (context, i) {
                  final t = state.tickets[i];
                  return ListTile(
                    title: Text(t.holderName),
                    subtitle: Text('${t.eventId} · ${t.issuedAt}'),
                    trailing: t.validated ? const Icon(Icons.check, color: Colors.green) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
